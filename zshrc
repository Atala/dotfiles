# Source oh-my-zsh if it is installed
if [[ -d $HOME/.oh-my-zsh ]]; then
    # Path to your oh-my-zsh configuration.
    ZSH=$HOME/.oh-my-zsh

    # Set name of the theme to load.
    #ZSH_THEME="intheloop"

    # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
    # Example format: plugins=(rails git textmate ruby lighthouse)
    plugins=(brew git python npm)

    # Load default oh-my-zsh stuff
    source $ZSH/oh-my-zsh.sh
fi

# use space to not log cmd in bash history
export HISTCONTROL=ignorespace

# autoload zsh functions
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

# Enable bash completion for git
# This allows git-completion to work properly
autoload bashcompinit
bashcompinit

# Fuzzy matching of completions for when you mistype them:
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Better color settings for ls output.
export LSCOLORS=ExFxCxDxBxegedabagacad

# Less Colors for Man Pages
# http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;33;246m'   # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

##########
# Prompt #
##########

autoload -U promptinit
promptinit

export ZSHSTART=1
precmd () {
    if [[ $ZSHSTART == 1 ]]; then
        export ZSHSTART=0
    else
        print ""
    fi

    local BEGPS="%(?..[%{$fg_bold[yellow]%}%?%{$reset_color%}])%n@%{$fg_bold[green]%}%m%{$reset_color%}:%{$fg_bold[cyan]%}"
    local ENDPS=" > "
    local pwdsize=${#${(%):-%~}}
    if [[ $pwdsize -lt 20 ]]; then
        export PS1="$BEGPS%~%{$reset_color%}$(prompt_git_info.sh)$ENDPS";
    else
        if [[ ${${(%):-%~}:0:1} == "~" ]]; then
            local trpwdsize=${#${(%):-\~/%2~}}
        else
            local trpwdsize=${#${(%):-%2~}}
        fi
        if [[ $pwdsize == $trpwdsize ]]; then
            export PS1="$BEGPS%~%{$reset_color%}$(prompt_git_info.sh)$ENDPS";
        else
            export PS1="$BEGPS$(get_root_symbol.sh)%2~%{$reset_color%}$(prompt_git_info.sh)$ENDPS";
        fi
    fi
}

# python configuration
if [ -f ~/.python_conf ]; then
. ~/.python_conf
fi

# add aliases
if [ -f ~/.aliases ]; then
. ~/.aliases
fi

export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}\007"'

# java
export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"

# Encoding (added by RVI)
export LC_ALL="en_US.UTF-8"

# Alt + arrow working on iTerm
bindkey -e
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word

docker_clean () {
    for i in $(docker ps -q --filter "status=exited"); do docker rm $i; done;
    docker rmi $(docker images -f "dangling=true" -q);
}

# Add SSH key at each terminal start on OSX High Sierra
ssh-add -K ~/.ssh/id_rsa &> /dev/null
ssh-add -K ~/.ssh/coopcycle_rsa &> /dev/null

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# java setup
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_162.jdk/Contents/Home

# added by travis gem
[ -f /Users/Alois/.travis/travis.sh ] && source /Users/Alois/.travis/travis.sh
