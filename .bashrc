# shellcheck disable=SC2034,SC1091
# shellcheck source=/dev/null
[[ "${_NAME_OF_THIS_LIBSCRIPT:-""}" == "yes" ]] && return 0
_NAME_OF_THIS_LIBSCRIPT=yes

# {{{ Umask

umask 0022

# }}}

# {{{ Includes

if [ -d ~/.sh/inc ]; then
  for rc in ~/.sh/inc/[0-9]*.sh; do
    # shellcheck source=/dev/null
		if [ -f "$rc" ]; then
      . "$rc"
		fi
		unset rc
  done
fi

# }}}

# {{{ Initial check

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
  # Shell is non-interactive.  Be done now!
  return
fi

# }}}

# {{{ History

HISTFILE=~/.bash_history
HISTFILESIZE=5000
HISTSIZE=5000
HISTCONTROL=ignoredups
shopt -s histappend
shopt -s cmdhist

# }}}

# {{{ XXX

red='\[\e[0;31m\]'
RED='\[\e[1;31m\]'
blue='\[\e[0;34m\]'
BLUE='\[\e[1;34m\]'
cyan='\[\e[0;36m\]'
CYAN='\[\e[1;36m\]'
green='\[\e[0;32m\]'
GREEN='\[\e[1;32m\]'
yellow='\[\e[0;33m\]'
YELLOW='\[\e[1;33m\]'
PURPLE='\[\e[1;35m\]'
purple='\[\e[0;35m\]'
nc='\[\e[0m\]'

if [ "$UID" = 0 ]; then
  PS1="$red\u$nc@$red\H$nc:$CYAN\w$nc\\n$red#$nc "
else
  PS1="$PURPLE\u$nc@$CYAN\H$nc:$GREEN\w$nc\\n$GREEN\$$nc "
fi

# Alias definitions.
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'
alias rm='trash-put'

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ "$WINDOWID" != "" ]; then
  [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
fi

[ -r /usr/share/kysec-auth/kysec_env.sh ] && . /usr/share/kysec-auth/kysec_env.sh

shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && . /usr/share/doc/fzf/examples/key-bindings.bash
# }}}

# vim:filetype=bash:tabstop=2:shiftwidth=2:fdm=marker:
