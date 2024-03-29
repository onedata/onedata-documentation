#!/usr/bin/env python3
"""
Checks Markdown files using dockerized LanguageTool toolkit for language errors.

This script is a wrapper for dockerized LTeX language server CLI
(https://github.com/valentjn/ltex-ls), which internally uses LanguageTool server
(https://github.com/languagetool-org/languagetool). When docs are developed in Visual Studio Code,
we use LTeX VSCode addon, which also uses whe LTeX language server, but not the CLI. The CLI can
utilize the `settings.json` file but unfortunately there are some bugs/differences compared to the
addon:
- the CLI does not respect "picky rules" setting,
- the CLI returns non-zero exit code when rules marked as "hint" are detected,
- the CLI always throws an exception on the successful run,
- the CLI throws an exception when the language error spans accross multiple lines and stops
  checking the rest of file.

To fix these inconsistences/bugs this script performs some additional operations when wrapping
execution of the LTeX CLI:
- it adds list of known "picky rules" manually using `enabledRules` settings (see `PICKY_RULES`
  list documentation in the code),
- it changes hint-rules into disabled rules by default and allows to specify `--show-hint` flag to
  check the hint-rules,
- it eats the "successful exception" from the output (see `RE_SUCCESS_EXCEPTION` regexp)
- it shows a reliable message when the multiple-lines exception is thrown (see
  `RE_MULTILINE_ERROR_EXCEPTION` regexp).

Compatible with Python 3.5+, needs the Docker installed.
"""

__author__ = "Jakub Liput"
__copyright__ = "Copyright (C) 2024 ACK CYFRONET AGH"
__license__ = "This software is released under the MIT license cited in LICENSE.txt"

import argparse
import json
import os
import re
import subprocess
import sys
import tempfile

VERSION_RE = re.compile(r"(\d+)\.(\d+)\.(\d+)")

LANGUAGETOOL_IMG = "docker.onedata.org/languagetool:v1"

SETTINGS_JSON_PATH = ".vscode/settings.json"
TMP_SETTINGS_JSON_PATH = "/tmp/"

CONFIG_DIAGNOSTIC_SEVERITY = "ltex.diagnosticSeverity"
CONFIG_DISABLED_RULES = "ltex.disabledRules"
CONFIG_ENABLED_RULES = "ltex.enabledRules"
CONFIG_EN_US = "en-US"
CONFIG_PICKY_RULES = "ltex.additionalRules.enablePickyRules"

TEXT_COLOR_RED = 31
TEXT_COLOR_GREEN = 32

# Matches the "successful run exception" - see more in module doc.
RE_SUCCESS_EXCEPTION = re.compile(
    r"^.*[AP]M org\.eclipse\.lsp4j\.jsonrpc\.json\.ConcurrentMessageProcessor run(.|\n)*more\s*$",
    re.MULTILINE,
)

# Matches the "multiline error exception" - see more in module doc.
RE_MULTILINE_ERROR_EXCEPTION = re.compile(
    r"^java\.lang\.StringIndexOutOfBoundsException(.|\n)*at org\.bsplines\.lspcli\.LspCliLauncher"
    + r"\.main\(LspCliLauncher\.kt\)\s*$",
    re.MULTILINE,
)

##
# The list of "picky"-level rules that are normally enabled in VSCode linter using the
# `"ltex.additionalRules.enablePickyRules": true` setting, but this does not work when using
# standalone LTeX CLI - we must add enable manually "picky" rules.
#
# The list is created by reading the source code of `languagetool`
# (https://github.com/languagetool-org/languagetool). The following files contain rules for English:
# - languagetool-language-modules/en/src/main/resources/org/languagetool/rules/en/en-US/grammar.xml
# - languagetool-language-modules/en/src/main/resources/org/languagetool/rules/en/en-US/style.xml
#
# The picky rules are tagged with `tags="picky"` in XML.
PICKY_RULES = [
    "CHILDISH_LANGUAGE",
    "CIRCUMSTANCES_SURROUNDING",
    "COVID_19",
    "DASH_RULE",
    "DO_MAKE_PRP_VBG",
    "DOES_XX_CAN",
    "DT_JJ_NO_NOUN",
    "EG_NO_COMMA",
    "EITHER_NOR",
    "ELLIPSIS",
    "EN_QUOTES",
    "FOUR_NN",
    "HAPPY_CHRISTMAS",
    "HONEST_TRUTH",
    "HYPHEN_TO_EN",
    "HYPOTHESIS_TYPOGRAPHY",
    "IE_NO_COMMA",
    "IN_A_X_MANNER",
    "LITTLE_BIT",
    "MISSING_PERIOD_AFTER_ABBREVIATION",
    "MULTIPLICATION_SIGN",
    "NON_STANDARD_COMMA",
    "NON_STANDARD_QUESTION_MARK",
    "NUMEROUS_DIFFERENT",
    "OCCASION_TRANSITIVE_VERB_VERY_FORMAL",
    "PASSIVE_VOICE",
    "PASSIVE_VOICE_SIMPLE",
    "PLUS_MINUS",
    "PPL",
    "PREVENT_FROM",
    "PROFANITY",
    "PROFANITY_TYPOS",
    "REASON_WHY",
    "REP_PASSIVE_VOICE",
    "RUDE_SARCASTIC",
    "SENT_START_CONJUNCTION",
    "SENT_START_NUM",
    "SENTENCE_FRAGMENT",
    "SERIAL_COMMA_ON",
    "SOME_OF_THE",
    "TAG_QUESTIONS_SVA",
    "TELL_IT",
    "THE_PROOF_IS_IN_THE_PUDDING",
    "THREE_NN",
    "TOO_TO_EITHER",
    "TRY_AND",
    "TWITTER_X",
    "TWO_HYPHENS",
    "TYPEWRITER_APOSTROPHE",
    "TYPOGRAPHICAL_APOSTROPHE",
    "UNIT_SPACE",
    "WHO_WHOM",
    "WHOLE_OTHER",
    "WILL_ALLOW",
    "WORD_CONTAINS_UNDERSCORE",
]


def create_arg_parser():
    parser = argparse.ArgumentParser(
        description="Checks Markdown files using dockerized LanguageTool toolkit for language "
        + "errors.",
    )

    parser.add_argument(
        "input_path",
        nargs="?",
        default="docs",
        help="A relative path starting from the project root to directory with Markdown files "
        + "(scanned recursively) or a single Markdown file path to check. Paths outside the "
        + "project directory are invalid.",
    )

    parser.add_argument(
        "--show-hints",
        default=False,
        action="store_true",
        help='Enables checking rules that have "hint" severity in original settings.json. '
        + 'By default rules with "hint" severity are not checked.',
    )

    parser.add_argument(
        "--quiet",
        default=False,
        action="store_true",
        help="Disables the output.",
    )

    return parser


def disable_hint_rules(settings_data):
    custom_severity_rules = settings_data[CONFIG_DIAGNOSTIC_SEVERITY]
    disabled_rules = settings_data[CONFIG_DISABLED_RULES][CONFIG_EN_US]
    hint_rules = list(
        filter(
            lambda rule_key: rule_key != "default"
            and custom_severity_rules[rule_key] == "hint",
            custom_severity_rules,
        )
    )

    for rule_key in hint_rules:
        disabled_rules.append(rule_key)
        del custom_severity_rules[rule_key]


def parse_settings_json():
    with open(SETTINGS_JSON_PATH, "r") as settings_reader:
        lines = settings_reader.readlines()

    # throw out comments from the JSON
    result = ''
    for line in lines:
        result += re.sub(
            r"\s*\/\/.*|((.*)((\"|\d|true|false|null),?|\[|\{))?(\s*\/\/.*)?",
            r"\1",
            line
        )

    return json.loads(result)


def create_settings_content(show_hints=False):
    settings_data = parse_settings_json()

    if not show_hints and CONFIG_DIAGNOSTIC_SEVERITY in settings_data:
        disable_hint_rules(settings_data)

    if CONFIG_PICKY_RULES in settings_data and settings_data[CONFIG_PICKY_RULES]:
        add_picky_rules(settings_data)

    return json.dumps(settings_data, indent="  ")


def add_picky_rules(settings_data):
    if (not CONFIG_ENABLED_RULES in settings_data) or (
        not CONFIG_EN_US in settings_data[CONFIG_EN_US]
    ):
        settings_data[CONFIG_ENABLED_RULES] = {CONFIG_EN_US: []}

    disabled_rules = settings_data[CONFIG_DISABLED_RULES][CONFIG_EN_US]
    non_disabled_picky_rules = filter(
        lambda rule: rule not in disabled_rules, PICKY_RULES
    )
    settings_data[CONFIG_ENABLED_RULES][CONFIG_EN_US].extend(non_disabled_picky_rules)


def color_text(text, color_code):
    return "\033[0;{}m{}\033[0m".format(color_code, text)


def exec_with_settings(settings_content, input_path, quiet):
    with tempfile.NamedTemporaryFile(mode="a") as tmp_settings_file:
        tmp_settings_file.write(settings_content)
        tmp_settings_file.flush()

        docker_project_root = "/onedata-documentation"

        process_args = [
            "docker",
            "run",
            "--rm",
            "-t",
            "-e",
            "TERM=xterm-256color",
            "-v",
            "{}:{}".format(os.getcwd(), docker_project_root),
            "-v",
            "{}:/settings.json".format(tmp_settings_file.name),
            LANGUAGETOOL_IMG,
            "--client-configuration=/settings.json",
            os.path.join(docker_project_root, input_path),
        ]

        result = subprocess.run(
            process_args,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
        )

        output = result.stdout.decode("utf-8")

    if result.returncode == 0:
        output = RE_SUCCESS_EXCEPTION.sub("", output)
    elif RE_MULTILINE_ERROR_EXCEPTION.search(output):
        output = RE_MULTILINE_ERROR_EXCEPTION.sub("", output)
        multiline_error_text = (
            "The latest language error spans accross mulitple lines. Due to "
            + "the bug in LTeX, the check stopped here. Fix the error and run check-language again."
        )
        output += "\n{}".format(color_text(multiline_error_text, TEXT_COLOR_RED))

    output = re.sub(r"\s*$", "", output, re.MULTILINE)

    if not quiet:
        if output != "":
            print(output)
        if result.returncode == 0:
            print(color_text("No language problems found.", TEXT_COLOR_GREEN))
        else:
            print(color_text("Some language problems have been found.", TEXT_COLOR_RED))

    return result.returncode


def main(args):
    settings_content = create_settings_content(show_hints=args.show_hints)
    return exec_with_settings(
        settings_content=settings_content, input_path=args.input_path, quiet=args.quiet
    )


if __name__ == "__main__":
    arg_parser = create_arg_parser()
    sys.exit(main(arg_parser.parse_args()))
