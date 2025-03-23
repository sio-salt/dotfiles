if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}[\[\033[01;32m\]\u \[\033[01;34m\]\W\[\033[00m\]\[\033[00;33m\]$(__git_ps1 " %s" 2>/dev/null)\[\033[00m\]]\n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi
