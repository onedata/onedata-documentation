#!/bin/bash
# This script checks if current contents of Markdown files are formatted as they would be
# formatted using Remark auto-formatter. The repository must be clean before perfoming
# test, because git is used for checking the diff.

cd "$(dirname "$0")"

if [ -z "$(git status --porcelain)" ]; then 
  make format-all
  if [ -z "$(git status --porcelain)" ]; then 
    echo "All files are formated properly."
    exit 0
  else
    echo "Some Markdown files are not formatted properly - use 'make format-all' command"
    echo "to auto-format all files."
    git reset --hard
    exit 1
  fi
else 
  echo "The repository must be clean before using this script."
  exit 2
fi
