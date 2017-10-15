status --is-interactive; and source (rbenv init -|psub)
set -x PATH $PATH /usr/local/share/git-core/contrib/diff-highlight

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
alias v="env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim"
alias va="vagrant"
alias vim="env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim"
alias he="heroku"
alias mas="master"
alias org="origin"
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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tkm_kj/google-cloud-sdk/path.fish.inc' ]; if type source > /dev/null; source '/Users/tkm_kj/google-cloud-sdk/path.fish.inc'; else; . '/Users/tkm_kj/google-cloud-sdk/path.fish.inc'; end; end
eval (direnv hook fish)
