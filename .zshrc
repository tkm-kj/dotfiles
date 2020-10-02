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

export PATH=$(pyenv root)/shims:$PATH:$GOPATH/bin:$PATH:/usr/local/share/git-core/contrib/diff-highlight:$HOME/google-cloud-sdk/bin:$HOME/.nodebrew/current/bin:$PATH:~/.rbenv/shims:$HOME/.goenv/bin:~/.nodenv/bin:/usr/local/bin:/usr/bin:/bin
export GOPATH=$HOME/dev
export GOROOT=""
export GO111MODULE=on
export PKG_CONFIG_PATH=/opt/ImageMagick/lib/pkgconfig

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

PROMPT=""
PROMPT+="%(?.%F{green}$OK%f.%F{196}$NG%f) "
PROMPT+="%F{130}[%~]%f"
PROMPT+="\$(vcs_prompt_info)"
PROMPT+="%% "

# -------------------------------------
# # エイリアス
# # -------------------------------------

alias ap="ansible-playbook"
alias be="bundle exec"
alias bi="bundle install"
alias bl="bundle list"
alias bo="bundle open"
alias bod="bundle outdated"
alias bu="bundle update"
alias da="docker attach"
alias dc="docker-compose"
alias dp="docker ps"
alias g="git"
alias gc="gcloud"
alias ka="kubectl apply -f"
alias kall="kubectl get all -o wide"
alias kb="kubectl"
alias kc="kubectx"
alias kd="kubectl describe"
alias ke="kubectl exec -it"
alias kn="kubens"
alias lg="lazygit"
alias ll="ls -l"
alias sz="source $HOME/.zshrc"
alias tm="tmux -2"
alias va="vagrant"

# -------------------------------------
# # キーバインド
# # -------------------------------------

bindkey -e

# -------------------------------------
# # その他
# # -------------------------------------
#

# コマンド履歴検索
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

if [ -f `brew --prefix`/etc/autojump ]; then
	  . `brew --prefix`/etc/autojump
fi
eval "$(rbenv init -)"
eval "$(nodenv init -)"
eval "$(pyenv init -)"
eval "$(goenv init -)"
eval "$(direnv hook zsh)"
