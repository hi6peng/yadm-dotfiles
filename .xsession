#!/bin/bash
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
# shellcheck source=/dev/null

userresources=~/.Xresources
usermodmap=~/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

SESSION=${1:-xfce}
STARTUP=$SESSION
if [ "$STARTUP" = "--" ];then
  SESSION=xfce
  STARTUP=xfce4-session
fi
#STARTUP=openbox-session

exec >~/.xsession.log 2>&1
umask 0022

# merge in defaults and keymaps
if [ -r $sysresources ]; then
  xrdb -merge $sysresources
fi

if [ -r $sysmodmap ]; then
  xmodmap $sysmodmap
fi

if [ -r "$userresources" ]; then
  xrdb -merge "$userresources"
fi

if [ -r "$usermodmap" ]; then
  xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

for i in ~/.sh/xinitrc.d/?* ; do
  [ -d "$i" ] && continue
  if [ -x "$i" ]; then
    if grep -q "# to be sourced" "$i"; then
      . "$i" "${SESSION}"
    else
      $i "${SESSION}" &
    fi
  fi
  unset i
done

# Local startup script
if [ -r ~/.xsession.local ]; then
  if grep -q "# to be sourced" ~/.xsession.local; then
    . ~/.xsession.local
  fi
fi

# openbox
if command -v tint2 >/dev/null 2>&1; then
  echo $STARTUP | ( grep -q 'openbox-session' && tint2 & )
fi

get_session(){
  case "$1" in
    awesome) xsession="awesome" ;;
    bspwm) xsession="bspwm-session" ;;
    budgie) xsession="budgie-desktop" ;;
    cinnamon) xsession="cinnamon-session" ;;
    deepin) xsession="startdde" ;;
    enlightenment) xsession="enlightenment_start" ;;
    fluxbox) xsession="startfluxbox" ;;
    gnome) xsession="gnome-session" ;;
    i3|i3wm) xsession="i3 --shmlog-size 0" ;;
    jwm) xsession="jwm" ;;
    kde) xsession="startplasma-x11" ;;
    lxde) xsession="startlxde" ;;
    lxqt) xsession="lxqt-session" ;;
    mate) xsession="mate-session" ;;
    xfce) xsession="xfce4-session" ;;
    openbox) xsession="openbox-session" ;;
    *) xsession="$1" ;;
  esac

  echo "$xsession"
}

exec "$(get_session "$SESSION")"
#exec $STARTUP
#exec /usr/bin/ssh-agent $STARTUP

# if we got here, then exec failed
exit 1

# vim:ft=sh:sw=2:
