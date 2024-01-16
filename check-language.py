#!/usr/bin/env python3
"""Author: Jakub Liput
Copyright (C) 2024 ACK CYFRONET AGH
This software is released under the MIT license cited in 'LICENSE.txt'

Checks Markdown files using dockerized LanguageTool toolkit for language errors.
"""

import argparse
import json
import os
import re
import subprocess
import sys
import tempfile

version_re = re.compile(r'(\d+)\.(\d+)\.(\d+)')

LANGUAGETOOL_IMG = 'docker.onedata.org/languagetool:v1'
settings_json_path = '.vscode/settings.json'
tmp_settings_json_path = '/tmp/'
config_diagnostic_severity = 'ltex.diagnosticSeverity'
config_disabled_rules = 'ltex.disabledRules'

re_success_exception = re.compile(
    r'^.*PM org\.eclipse\.lsp4j\.jsonrpc\.json\.ConcurrentMessageProcessor run(.|\n)*more$',
    re.MULTILINE
)

parser = argparse.ArgumentParser(
    prog='check-language',
    description='FIXME:',
)

# FIXME: zawijanie wierszy w stringach
parser.add_argument(
    'input',
    nargs='?',
    default='docs',
    help='A relative path starting from the project root to directory with Markdown files (scanned recursively) or a single Markdown file path to check. Paths outside the project directory are invalid.'
)

args = parser.parse_args()

input_path = args.input


def create_settings_content():
    with open(settings_json_path, 'r') as settings_reader:
        settings_content = settings_reader.read()
        settings_data = json.loads(settings_content)

        custom_severity_rules: dict[str,
                                    str] = settings_data[config_diagnostic_severity]
        disabled_rules: list[str] = settings_data[config_disabled_rules]['en-US']
        hint_rules = list(filter(
            lambda rule_key: rule_key != 'default' and custom_severity_rules[rule_key] == 'hint',
            custom_severity_rules
        ))

        for rule_key in hint_rules:
            disabled_rules.append(rule_key)
            del custom_severity_rules[rule_key]

        return json.dumps(settings_data, indent='  ')


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
                print('\033[0;32mNo language problems found.\033[0m')
            else:
                print('\033[0;31mSome language problems have been found.\033[0m')

        return result.returncode


def main() -> int:
    settings_content = create_settings_content()
    return exec_with_settings(settings_content)


if __name__ == '__main__':
    sys.exit(main())
