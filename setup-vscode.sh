#!/bin/bash

cd "$(dirname "$0")"

if [ -f ./.vscode/settings.json ]; then
  read -p "settings.json already exists for current workspace - do you want to overwrite it with recommended settings? (yes/no) " answer
  case $answer in
    y|yes) ;;
    *|no) exit 1;;
  esac
fi

echo "Copying recommended Visual Studio Code workspace settings to .vscode/settings.json"
cp ./.vscode.example/settings.json ./.vscode
