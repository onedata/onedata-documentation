#!/usr/bin/env python3
"""Author: Jakub Liput
Copyright (C) 2024 ACK CYFRONET AGH
This software is released under the MIT license cited in 'LICENSE.txt'

Checks Markdown files using dockerized LanguageTool toolkit for language errors.
"""

# FIXME: formatowanie i uwagi analogiczne do brancha onepanel-swagger z emberem 3.12

import argparse
import json
import os
import re
import subprocess
import sys
import tempfile

# FIXME: pewnie wielkie litery

version_re = re.compile(r'(\d+)\.(\d+)\.(\d+)')

LANGUAGETOOL_IMG = 'docker.onedata.org/languagetool:v1'
settings_json_path = '.vscode/settings.json'
tmp_settings_json_path = '/tmp/'
config_diagnostic_severity = 'ltex.diagnosticSeverity'
config_disabled_rules = 'ltex.disabledRules'
config_enabled_rules = 'ltex.enabledRules'
config_en_us = 'en-US'
config_picky_rules = 'ltex.additionalRules.enablePickyRules'

TEXT_COLOR_RED = 31
TEXT_COLOR_GREEN = 32

re_success_exception = re.compile(
    r'^.*PM org\.eclipse\.lsp4j\.jsonrpc\.json\.ConcurrentMessageProcessor run(.|\n)*more$',
    re.MULTILINE
)

parser = argparse.ArgumentParser(
    description='FIXME: description',
)

# FIXME: zawijanie wierszy w stringach
parser.add_argument(
    'input_path',
    nargs='?',
    default='docs',
    help='A relative path starting from the project root to directory with Markdown files (scanned recursively) or a single Markdown file path to check. Paths outside the project directory are invalid.'
)

parser.add_argument(
    '--show-hints',
    default=False,
    action='store_true',
    help='FIXME:'
)

args = parser.parse_args()

input_path = args.input_path

##
# The list of "picky"-level rules that are normally enabled in VSCode linter using the `"ltex.additionalRules.enablePickyRules": true` setting, but this does not work when using standalone LTeX CLI - we must add enable manually "picky" rules.
#
# The list is created by reading the source code of `languagetool` (https://github.com/languagetool-org/languagetool). The following files contain rules for English:
# - languagetool-language-modules/en/src/main/resources/org/languagetool/rules/en/en-US/grammar.xml
# - languagetool-language-modules/en/src/main/resources/org/languagetool/rules/en/en-US/style.xml
#
# The picky rules are tagged with `tags="picky"` in XML.
#
PICKY_RULES = [
    'CHILDISH_LANGUAGE',
    'CIRCUMSTANCES_SURROUNDING',
    'COVID_19',
    'DASH_RULE',
    'DO_MAKE_PRP_VBG',
    'DOES_XX_CAN',
    'DT_JJ_NO_NOUN',
    'EG_NO_COMMA',
    'EITHER_NOR',
    'ELLIPSIS',
    'EN_QUOTES',
    'FOUR_NN',
    'HAPPY_CHRISTMAS',
    'HONEST_TRUTH',
    'HYPHEN_TO_EN',
    'HYPOTHESIS_TYPOGRAPHY',
    'IE_NO_COMMA',
    'IN_A_X_MANNER',
    'LITTLE_BIT',
    'MISSING_PERIOD_AFTER_ABBREVIATION',
    'MULTIPLICATION_SIGN',
    'NON_STANDARD_COMMA',
    'NON_STANDARD_QUESTION_MARK',
    'NUMEROUS_DIFFERENT',
    'OCCASION_TRANSITIVE_VERB_VERY_FORMAL',
    'PASSIVE_VOICE',
    'PASSIVE_VOICE_SIMPLE',
    'PLUS_MINUS',
    'PPL',
    'PREVENT_FROM',
    'PROFANITY',
    'PROFANITY_TYPOS',
    'REASON_WHY',
    'REP_PASSIVE_VOICE',
    'RUDE_SARCASTIC',
    'SENT_START_CONJUNCTION',
    'SENT_START_NUM',
    'SENTENCE_FRAGMENT',
    'SERIAL_COMMA_ON',
    'SOME_OF_THE',
    'TAG_QUESTIONS_SVA',
    'TELL_IT',
    'THE_PROOF_IS_IN_THE_PUDDING',
    'THREE_NN',
    'TOO_TO_EITHER',
    'TRY_AND',
    'TWITTER_X',
    'TWO_HYPHENS',
    'TYPEWRITER_APOSTROPHE',
    'TYPOGRAPHICAL_APOSTROPHE',
    'UNIT_SPACE',
    'WHO_WHOM',
    'WHOLE_OTHER',
    'WILL_ALLOW',
    'WORD_CONTAINS_UNDERSCORE',
]


def disable_hint_rules(settings_data: dict[str, str]):
    custom_severity_rules: dict[str, str] = settings_data[config_diagnostic_severity]
    disabled_rules: list[str] = settings_data[config_disabled_rules][config_en_us]
    hint_rules = list(filter(
        lambda rule_key: rule_key != 'default' and custom_severity_rules[rule_key] == 'hint',
        custom_severity_rules
    ))

    for rule_key in hint_rules:
        disabled_rules.append(rule_key)
        del custom_severity_rules[rule_key]


def read_settings_content():
    with open(settings_json_path, 'r') as settings_reader:
        return settings_reader.read()


def create_settings_content():
    settings_content: str = read_settings_content()
    settings_data: dict[str, str] = json.loads(settings_content)

    if not args.show_hints and config_diagnostic_severity in settings_data:
        disable_hint_rules(settings_data)

    if config_picky_rules in settings_data and settings_data[config_picky_rules] == True:
        add_picky_rules(settings_data)

    return json.dumps(settings_data, indent='  ')


def add_picky_rules(settings_data: dict[str, str]):
    if (not config_enabled_rules in settings_data) or (not config_en_us in settings_data[config_en_us]):
        settings_data[config_enabled_rules] = {config_en_us: []}

    disabled_rules = settings_data[config_disabled_rules][config_en_us]
    non_disabled_picky_rules = filter(lambda rule: rule not in disabled_rules, PICKY_RULES)
    settings_data[config_enabled_rules][config_en_us].extend(non_disabled_picky_rules)


def color_text(text: str, color_code: int):
    return f'\033[0;{color_code}m{text}\033[0m'


def exec_with_settings(settings_content: str, quiet=False):
    with tempfile.NamedTemporaryFile(mode='a') as tmp_settings_file:
        tmp_settings_file.write(settings_content)
        tmp_settings_file.flush()

        docker_project_root = '/onedata-documentation'

        process_args = [
            'docker',
            'run',
            '--rm',
            '-t',
            '-e',
            'TERM=xterm-256color',
            '-v',
            f'{os.getcwd()}:{docker_project_root}',
            '-v',
            # FIXME: odporność na spacje?
            f'{tmp_settings_file.name}:/settings.json',
            LANGUAGETOOL_IMG,
            '--client-configuration=/settings.json',
            os.path.join(docker_project_root, input_path)
        ]

        result = subprocess.run(
            process_args,
            capture_output=True,
            text=True,
        )

        output = result.stdout

        if (result.returncode == 0):
            output = re_success_exception.sub('', output)
            output = re.sub(r'\s*$', '', output, re.MULTILINE)

        if not quiet:
            if output != '':
                print(output)
            if (result.returncode == 0):
                print(color_text('No language problems found.', TEXT_COLOR_GREEN))
            else:
                print(color_text('Some language problems have been found.', TEXT_COLOR_RED))

        return result.returncode


def main() -> int:
    settings_content = create_settings_content()
    return exec_with_settings(settings_content)


if __name__ == '__main__':
    sys.exit(main())
