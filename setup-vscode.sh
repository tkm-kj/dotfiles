#!/bin/sh

set -euo pipefail

function main() {
  echo 'Start VSCode setup'
  ln -fs $HOME/dotfiles/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json

  cat vscode/extensions | while read line
  do
    code --install-extension $line
  done
  echo 'Finish VSCode setup'
}

main "$@"
