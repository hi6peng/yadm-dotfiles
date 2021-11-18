#!/bin/bash
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

STARTUP=xfce4-session
#STARTUP=openbox-session

exec >"$HOME/.xsession.log" 2>&1
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

if type xhost >/dev/null 2>&1; then
  xhost +si:localuser:$(id -un) || :
fi

# start some nice programs

#if [ -d /etc/X11/xinit/xinitrc.d ] ; then
#  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#    [ -x "$f" ] && . "$f"
#  done
#  unset f
#fi

#if [ -r "$HOME/.xinputrc" ]; then
#  . $HOME/.xinputrc
#fi
if [ -r "/etc/X11/Xsession.d/70im-config_launch" ]; then
  . /etc/X11/Xsession.d/70im-config_launch
fi

if [ "x$DESKTOP_SESSION" = "xxfce" ] || [ "x$XDG_SESSION_DESKTOP" = "xxfce" ]; then
  # Workaround clutter issue (LP: #1462445)
  export CLUTTER_BACKEND=x11

  export XMODIFIERS=@im=fcitx
  export GTK_IM_MODULE=fcitx
  export QT4_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export CLUTTER_IM_MODULE=fcitx
fi

systemctl --user import-environment XMODIFIERS GTK_IM_MODULE QT4_IM_MODULE QT_IM_MODULE CLUTTER_IM_MODULE
if which dbus-update-activation-environment >/dev/null 2>&1; then
  dbus-update-activation-environment XMODIFIERS GTK_IM_MODULE QT4_IM_MODULE QT_IM_MODULE CLUTTER_IM_MODULE
fi

os_type="$(grep -oP "^ID=\"\K.*?(?=\")" /etc/os-release)";
if [[ "${os_type}" == 'opensuse-leap' ]]; then
  XIMFILE=/etc/X11/xim
  test -r $HOME/.xim && XIMFILE=$HOME/.xim
  test -r $XIMFILE  && source $XIMFILE
fi

# Local startup script
if [ -r "$HOME/.xsession.local" ]; then
  . "$HOME/.xsession.local"
fi

# openbox
echo $STARTUP | grep -q 'openbox-session' && tint2 &

exec $STARTUP
#exec /usr/bin/ssh-agent $STARTUP

# if we got here, then exec failed
exit 1

# vim:ft=sh:sw=2:
