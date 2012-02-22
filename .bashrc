# Comment in the above and uncomment this below for a color prompt

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true

PS1='\[\e[01;33m\]\u@\H\[\e[00;32m\][\w]\[\e[0m\]\[\e[01;34m\]$(__git_ps1 "(%s)")\[\e[0m\] '

# Load bash aliases
if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
fi

# Enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        . /etc/bash_completion
fi

# VIM as default text editor
export EDITOR=/usr/bin/vim

# less with clor
export LESS=-R

# Bash symfony completion
_symfony()
{
        local cmds cur colonprefixes

        cmds="$( ${COMP_WORDS[0]} | perl -ne 'if( /^([a-zA-Z0-9\-]+)/ ) { $first = $1; } elsif ( /^\s*(:[a-zA-Z0-9\-]+)/ ) { print $first . $1 . "\n"; }' )"
        COMPREPLY=()
        cur=${COMP_WORDS[COMP_CWORD]}
        # Work-around bash_completion issue where bash interprets a colon as a separator.
        # Work-around borrowed from the darcs work-around for the same issue.
        colonprefixes=${cur%"${cur##*:}"}
        COMPREPLY=( $(compgen -W '$cmds' -- $cur))
        local i=${#COMPREPLY[*]}
        while [ $((--i)) -ge 0 ]; do
                COMPREPLY[$i]=${COMPREPLY[$i]#"$colonprefixes"}
        done

        return 0
} &&
complete -F _symfony symfony

#Enhance man page
export PAGER=`which most`

