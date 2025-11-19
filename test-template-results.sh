#!/bin/bash

# Authors: Jakub Liput
# Copyright (C) 2025 ACK CYFRONET AGH
# This software is released under the MIT license cited in 'LICENSE.txt'

# This script checks if current contents in current branch of template results in Markdown
# files are generated from the current contents of templates and partials. The repository
# must be clean before perfoming test, because git is used for checking the diff.

cd "$(dirname "$0")"

if [ -z "$(git status --porcelain)" ]; then 
  make render-templates
  if [ -z "$(git status --porcelain)" ]; then 
    echo "All files generated from templates are up to date."
    exit 0
  else
    echo "There are some files generated from templates that are not compliant with "
    echo "current templates or partials. Use 'make render-templates' and commit changes."
    git reset --hard
    exit 1
  fi
else 
  echo "The repository must be clean before using this script."
  exit 2
fi
