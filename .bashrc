# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -al --color=auto'
alias df='df -h'
alias du='du -h'
PS1='[\u@\h \W]\$ '
