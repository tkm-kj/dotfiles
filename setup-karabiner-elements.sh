#!/bin/sh

set -euo pipefail

function main() {
  echo 'Start Karabiner-Elements setup'
  ln -fs $HOME/dotfiles/karabiner-elements/hotkeys_switch_app.json ~/.config/karabiner/assets/complex_modifications
  echo 'Finish Karabiner-Elements setup'
}

main "$@"
