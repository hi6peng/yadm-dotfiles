. ~/.sh/inc/functions

# {{{ Vars

: "${OS:=$(uname -s)}"
: "${UID:=$(id -u)}"

# }}}

# {{{ Path

if [ "${OS}" != "Darwin" ]; then
  PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
fi
# OSX
if [ -x /usr/libexec/path_helper ]; then
  eval "$(/usr/libexec/path_helper -s)"
fi
PATH="${HOME}/.local/bin:${PATH}"
export PATH

# }}}

# {{{ Locale

LOCALE="en_US.UTF-8"
LANG="${LOCALE}"
# LC_ALL="${LOCALE}"
LC_COLLATE="${LOCALE}"
LC_CTYPE="${LOCALE}"
LC_MESSAGES="${LOCALE}"
LC_MONETARY="${LOCALE}"
LC_NUMERIC="${LOCALE}"
LC_TIME="${LOCALE}"
MM_CHARSET="UTF-8"
export LANG LC_COLLATE LC_CTYPE LC_MESSAGES LC_MONETARY LC_NUMERIC LC_TIME MM_CHARSET

# }}}

# {{{ Editor

EDITOR="vi"
VISUAL="vi"
if command -v vim >/dev/null 2>&1; then
  EDITOR="vim"
  VISUAL="vim"
fi
export EDITOR VISUAL

# }}}

# {{{ Pager

#PAGER="more"
#if command -v less >/dev/null 2>&1; then
#  PAGER="less"
#  LESS="-i -M -R --shift 5"; export LESS
#  LESS_TERMCAP_mb=$'\e[1;34m'  # begin bold
#  LESS_TERMCAP_md=$'\e[1;34m'  # begin blink
#  LESS_TERMCAP_me=$'\e[0m'     # reset bold/blink
#  LESS_TERMCAP_so=$'\e[01;35m' # begin reverse video
#  LESS_TERMCAP_se=$'\e[0m'     # reset reverse video
#  LESS_TERMCAP_us=$'\e[1;32m'  # begin underline
#  LESS_TERMCAP_ue=$'\e[0m'     # reset underline
#  export LESS_TERMCAP_mb LESS_TERMCAP_md LESS_TERMCAP_me LESS_TERMCAP_so \
#    LESS_TERMCAP_se LESS_TERMCAP_us LESS_TERMCAP_ue
#  if command -v lesspipe >/dev/null 2>&1; then
#    eval "$(lesspipe)"
#  elif command -v lesspipe.sh >/dev/null 2>&1; then
#    LESSOPEN='|lesspipe.sh %s'; export LESSOPEN
#    LESS_ADVANCED_PREPROCESSOR=1; export LESS_ADVANCED_PREPROCESSOR
#  fi
#fi
#export PAGER

# }}}

# {{{ Bat

BAT_THEME="Nord"; export BAT_THEME

# }}}

# {{{ Du

BLOCKSIZE="K"; export BLOCKSIZE

# }}}

# {{{ My Data disk

[ -d /data ] && DATA=/data || DATA=$HOME
APPS=$DATA/Apps

# }}}

# {{{ jdk, maven, nodejs, ant PATH

JAVA_HOME=$APPS/jdk
[ -d $JAVA_HOME ] && { export JAVA_HOME=$JAVA_HOME; pathedit -p $JAVA_HOME/bin; }
[ -d $APPS/maven/bin ] && pathedit -p $APPS/maven/bin
[ -d $APPS/nodejs/bin ] && pathedit -p $APPS/nodejs/bin
[ -d $APPS/ant/bin ] && pathedit -p $APPS/ant/bin
[ -d $HOME/.npm-global/bin ] && pathedit -p $HOME/.npm-global/bin

if command -v ruby >/dev/null 2>&1; then
  export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
  pathedit -p $GEM_HOME/bin
fi

export PATH

# }}}

# {{{ pydev, sublime

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/workspace/sublime

# }}}

# {{{ terminal

# Begin protected block
if [ -t 0 ]; then       # check for a terminal
  [ x"$TERM" = x"wy30" ] && stty erase ^h       # sample legacy environment
  echo -e "Welcome to Debian, $LOGNAME"
  #/usr/games/fortune
fi
# End protected block

# }}}

# {{{ path

# Add sbin directories to PATH.  This is useful on systems that have sudo
pathedit -a "/sbin"
pathedit -a "/usr/sbin"

# }}}

# vim:filetype=sh:tabstop=2:shiftwidth=2:fdm=marker:
