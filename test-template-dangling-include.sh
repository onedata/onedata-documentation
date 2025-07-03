#!/bin/bash

# Authors: Jakub Liput
# Copyright (C) 2025 ACK CYFRONET AGH
# This software is released under the MIT license cited in 'LICENSE.txt'

# Checks if final Markdown documents do not contain `**@include` directives, which would
# mean, that some templates were not compiled properly (some partials were missing).

cd "$(dirname "$0")"

grep --include '*.md' -r '**@include' docs
GREP_RESULT=$?
if [ $GREP_RESULT -eq 0 ]; then 
  echo "Some files generated from templates contain **@include directives, that means some "
  echo "includes were not resolved properly. Review your templates and partials."
  exit 1
else
  echo "All generated templates are free from dangling includes."
  exit 0
fi