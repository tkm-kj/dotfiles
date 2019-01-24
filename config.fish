status --is-interactive; and source (rbenv init -|psub)
set -x PATH $PATH /usr/local/share/git-core/contrib/diff-highlight $HOME/google-cloud-sdk/bin
set -x GOPATH $GOPATH $HOME/dev

alias ap="ansible-playbook"
alias be="bundle exec"
alias bi="bundle install"
alias bl="bundle list"
alias bo="bundle open"
alias bod="bundle outdated"
alias bu="bundle update"
alias ct='ctags --langmap=RUBY:.rb --exclude="*.js"  --exclude=".git*" -R .'
alias dc="docker-compose"
alias g="git"
alias ll="ls -l"
alias va="vagrant"
alias he="heroku"
alias mas="master"
alias org="origin"
alias r="bin/rails"
alias red="RAILS_ENV=development"
alias rep="RAILS_ENV=production"
alias ret="RAILS_ENV=test"

function fish_prompt --description 'Write out the prompt'
        #Save the return status of the previous command
    set stat $status

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __fish_color_brown
        set -g __fish_color_brown (set_color -o brown)
    end

    #Set the color for the status depending on the value
    set __fish_color_status (set_color -o green)
    if test $stat -gt 0
        set __fish_color_status (set_color -o red)
    end

    if not set -q __git_cb
				set __git_cb ""(git branch ^/dev/null | grep \* | sed 's/* //')""
    end

    if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end

    printf '[%s] %s%s %s(%s)%s [%s] \f\r$ ' (date "+%H:%M:%S") "$__fish_prompt_cwd" "$PWD" "$__fish_color_status" "$stat" "$__fish_color_brown" "$__git_cb"
end
eval (direnv hook fish)

function peco_select_history
  if test (count $argv) = 0
    set peco_flags --layout=bottom-up
  else
    set peco_flags --layout=bottom-up --query "$argv"
  end

  history|peco $peco_flags|read foo

  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end

function fish_user_key_bindings
    bind \cr peco_select_history
end
