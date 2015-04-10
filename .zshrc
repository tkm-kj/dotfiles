# -------------------------------------
# # 環境変数
# # -------------------------------------
#
# # SSHで接続した先で日本語が使えるようにする
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# エディタ
export EDITOR=/usr/local/bin/vim

# ページャ
export PAGER=/usr/local/bin/vimpager
export MANPAGER=/usr/local/bin/vimpager

# -------------------------------------
# # zshのオプション
# # -------------------------------------
#
# ## 補完機能の強化
autoload -U compinit
compinit

## 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt correct

# ビープを鳴らさない
setopt nobeep

## 色を使う
setopt prompt_subst

## ^Dでログアウトしない。
setopt ignoreeof

## バックグラウンドジョブが終了したらすぐに知らせる。
setopt no_tify

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

# 補完
# ## タブによるファイルの順番切り替えをしない
unsetopt auto_menu

# cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
setopt auto_pushd

# ディレクトリ名を入力するだけでcdできるようにする
setopt auto_cd

# 同じディレクトリは追加しない
setopt pushd_ignore_dups

# #--- zsh 用の設定 ---
# . /usr/local/etc/autojump.zsh

# #--- cd 時の仕掛け ---
# function precmd () {
#     pwd=`pwd`
#     echo "[^[[35m$pwd^[[m]"
#     autojump -a $pwd
#     echo $pwd > ~/.curdir
# }

# -------------------------------------
# # パス
# # -------------------------------------
#
# # 重複する要素を自動的に削除
typeset -U path cdpath fpath manpath

path=(
  $HOME/bin(N-/)
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  $path
)

# -------------------------------------
# # プロンプト
# # -------------------------------------
#
autoload -U promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least

# begin VCS
zstyle ":vcs_info:*" enable git svn hg bzr
zstyle ":vcs_info:*" formats "(%s)-[%b]"
zstyle ":vcs_info:*" actionformats "(%s)-[%b|%a]"
zstyle ":vcs_info:(svn|bzr):*" branchformat "%b:r%r"
zstyle ":vcs_info:bzr:*" use-simple true

zstyle ":vcs_info:*" max-exports 6

if is-at-least 4.3.10; then
	zstyle ":vcs_info:git:*" check-for-changes true # commitしていないのをチェック
	zstyle ":vcs_info:git:*" stagedstr "<S>"
	zstyle ":vcs_info:git:*" unstagedstr "<U>"
	zstyle ":vcs_info:git:*" formats "(%b) %c%u"
	zstyle ":vcs_info:git:*" actionformats "(%s)-[%b|%a] %c%u"
fi

function vcs_prompt_info() {
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && echo -n " %{$fg[yellow]%}$vcs_info_msg_0_%f"
}

# end VCS

OK="OK"
NG="NG"

rbenv_ver="[ruby:`rbenv version | cut -f1 -d' '`]"

PROMPT=""
PROMPT+="%(?.%F{green}$OK%f.%F{196}$NG%f) "
PROMPT+="\$(vcs_prompt_info)"
PROMPT+="%% "

RPROMPT=""
RPROMPT+="%F{120}$rbenv_ver"

# -------------------------------------
# # エイリアス
# # -------------------------------------

alias be="bundle exec"
alias bo="bundle open"
alias brc="./bin/rails c"
alias brd="./bin/rake db:migrate"
alias brs="./bin/rails s"
alias bsr="./bin/spring rspec"
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gch="git checkout"
alias gco="git commit"
alias gd="git diff"
alias gk="gitk"
alias gl="git log -5 --reverse --stat"
alias gm="git merge"
alias gr="git rm"
alias gs="git status"
alias ll="ls -l"
alias rb="ruby"
alias sz="source $HOME/.zshrc"
alias tm="tmux -2"
alias tree="tree -NC" # N: 文字化け対策, C:色をつける
alias v="vim"
alias va="vagrant"

alias -g ma="master"
alias -g or="origin"
alias -g red="RAILS_ENV=development"
alias -g rep="RAILS_ENV=production"
alias -g ret="RAILS_ENV=test"

# -------------------------------------
# # キーバインド
# # -------------------------------------

bindkey "^R" history-incremental-search-backward

# -------------------------------------
# # その他
# # -------------------------------------
#
# # cdしたあとで、自動的に ls する
function chpwd() { pwd; ls -1 }

# コマンド履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^j" history-beginning-search-backward-end
bindkey "^k" history-beginning-search-forward-end
# 補完候補を詰めて表示する
setopt list_packed

if [ -f `brew --prefix`/etc/autojump ]; then
	  . `brew --prefix`/etc/autojump
fi
