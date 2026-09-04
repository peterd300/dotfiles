# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# include timestamps in the output of the history command
HISTTIMEFORMAT="%d/%m/%y %T "

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTFILESIZE=50000
export HISTSIZE=10000
export HISTCONTROL=$HISTCONTROL:ignoreboth
export HISTFILE=/home/$(whoami)/.bash_history


# aliasses

alias ..='cd ..'
alias ...='cd ../..'
#alias ls='ls --color=auto'
#alias ll='ls -al --color=auto'
alias ls='eza --group-directories-first --git'
alias ll='eza -la --group-directories-first --git'
alias e='micro'
alias df='df -h'
alias du='du -h'
alias nano='nano -l'
alias ff='fastfetch'

# xbps aliases
alias xi='sudo xbps-install -Sy'
alias xu='sudo xbps-install -Su'
alias xq='sudo xbps-query -Rs'


# Git aliases
alias gp="git push -u origin main"
alias gsave="git commit -m 'save'"
alias gm="git commit"
alias gs="git status"
alias gc="git clone"


# PS1='[\u@\h \W]\$ '




export PATH="$HOME/scripts:$HOME/.local/bin:$PATH"
export EDITOR=$(command -v nvim || command -v micro || echo nano)
export VISUAL="$EDITOR"

#thanks to JustALinuxGuy
# PS1 Customization

# PS1="\[\e[32m\]\h\[\e[m\]\[\e[36m\]@\[\e[m\]\[\e[34m\]\u\[\e[m\] \W \$ "

# Colour codes
RED="\\[\\e[1;31m\\]"
GREEN="\\[\\e[1;32m\\]"
YELLOW="\\[\\e[1;33m\\]"
BLUE="\\[\\e[1;34m\\]"
MAGENTA="\\[\\e[1;35m\\]"
CYAN="\\[\\e[1;36m\\]"
WHITE="\\[\\e[1;37m\\]"
ENDC="\\[\\e[0m\\]"

# Set a two-line prompt. If accessing via ssh include 'ssh-session' message.
if [[ -n "$SSH_CLIENT" ]]; then ssh_message="-ssh_session"; fi
PS1="${GREEN}\u ${WHITE}at ${YELLOW}\h${RED}${ssh_message} ${WHITE}in ${BLUE}\w \n${CYAN}\$${ENDC} "



# Handy git function by https://learn-linux.com/

my_git() {
GIT_BRANCH=$(git branch --all 2> /dev/null | egrep "^\*" | cut -d ' ' -f 2 )
if [[ -z "$GIT_BRANCH" ]]; then
       echo "" #not in a Git repo
else
    if [ $(git status | egrep "^Untracked" -c) -ge 1 ]; then
        #ANSI code: Red
        echo -e "(\033[0;31m$GIT_BRANCH\033[0m) "
    elif  [ $(git status | egrep "^Changes" -c) -ge 1 ]; then
        #ANSI code: Yellow
        echo -e "(\033[0;33m$GIT_BRANCH\033[0m) "
    else
        #ANSI code: Green
        echo -e "(\033[0;32m$GIT_BRANCH\033[0m) "
    fi
fi
}
# PS1 variable:
# export PS1="\[\e]0;\u@\h: \w\a\]\u@\h:\w$ \$(my_git)"

# init starship promtp
eval "$(starship init bash)"

# Init zoxide
eval "$(zoxide init bash)"
