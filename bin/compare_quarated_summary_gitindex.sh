#!/usr/bin/env bash

echo "Files from QURATED in SUMMARY"
grep --color=auto -f <(grep -v -e '^$' -e '^#' <QURATED) -e '$' SUMMARY.md

echo "Files from SUMMARY in QURATED"
grep --color=auto -f <(grep -o --color=auto -f <(grep -v -e '^$' -e '^#' <QURATED)   SUMMARY.md | sort | uniq) -e '$' QURATED

echo "*md files from git ls-files in QURATED"
grep --color=auto -f <(grep -v -e '^$' -e '^#' <QURATED) -e '$' <(git ls-files | grep ".md$") 