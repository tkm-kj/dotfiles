#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOT_FILES=(.vimrc .vimrc.setting.vim .vimrc.keymap.vim .zshrc .tmux.conf .gitconfig)

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" # brew入れる
brew update
brew install peco ghq mise autojump direnv tmux

for file in ${DOT_FILES[@]}
do
  ln -fs $SCRIPT_DIR/$file $HOME/$file
done

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
sh ~/.tmux/plugins/tpm/scripts/install_plugins.sh

echo 'Finish!'
