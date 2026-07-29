# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -al --color=auto'
alias df='df -h'
alias du='du -h'
alias nano='nano -l'
alias xi='sudo xbps-install -Sy'
alias xu='sudo xbps-install -Su'
alias xq='sudo xbps-query -Rs'
PS1='[\u@\h \W]\$ '
