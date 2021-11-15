#!/bin/bash
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

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

if [ -r "$HOME/.xinputrc" ]; then
  . $HOME/.xinputrc
fi

# Local startup script
if [ -r "$HOME/.xsession.local" ]; then
  . "$HOME/.xsession.local"
fi

# xfce4
#exec xfce4-session || echo 'Failed to launch xfce4'

# openbox
tint2 &
#exec im-launch openbox-session || echo 'Failed to launch openbox'
exec openbox-session || echo 'Failed to launch openbox'

# vim:ft=sh:sw=2:
