# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return



alias ..='cd ..' 
alias ...='cd ../..' 
alias ls='ls --color=auto'
alias ll='ls -al --color=auto'
alias df='df -h'
alias du='du -h'
alias nano='nano -l'

# xbps aliases
alias xi='sudo xbps-install -Sy'
alias xu='sudo xbps-install -Su'
alias xq='sudo xbps-query -Rs'


# Git aliases
alias gp="git push -u origin main"
alias gsave="git commit -m 'save'"
alias gm="git commit -m"
alias gs="git status"
alias gc="git clone"


# PS1='[\u@\h \W]\$ '




export PATH="$HOME/scripts:$HOME/.local/bin:$PATH"
export EDITOR=$(command -v nvim || command -v micro || echo nano)
export VISUAL="$EDITOR"

#thanks to JustALinuxGuy
# PS1 Customization

#PS1="\[\e[32m\]\h\[\e[m\]\[\e[36m\]@\[\e[m\]\[\e[34m\]\u\[\e[m\] \W \$ " 

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
