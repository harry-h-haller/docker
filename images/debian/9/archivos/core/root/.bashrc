export PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
umask 0022

export LS_OPTIONS='--color=auto'
eval "`dircolors`"

[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bash_functions ] && . ~/.bash_functions
