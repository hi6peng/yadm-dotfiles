#!/bin/bash
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

SESSION=${1:-xfce}
STARTUP=$SESSION
if [ $STARTUP == "--" ];then
  SESSION=xfce
  STARTUP=xfce4-session
fi
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
  xhost +local:root > /dev/null 2>&1
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

#if [ -r "$HOME/.xinputrc" ]; then
#  . $HOME/.xinputrc
#fi
#ubuntu
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

# Load systemd-user.sh
if [ -f /etc/X11/xinit/xinitrc.d/50-systemd-user.sh ]; then
  . /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
else
  systemctl --user import-environment XMODIFIERS GTK_IM_MODULE QT4_IM_MODULE QT_IM_MODULE CLUTTER_IM_MODULE
  if which dbus-update-activation-environment >/dev/null 2>&1; then
    dbus-update-activation-environment XMODIFIERS GTK_IM_MODULE QT4_IM_MODULE QT_IM_MODULE CLUTTER_IM_MODULE
  fi
fi

os_type="$(grep -oP "^ID=\"\K.*?(?=\")" /etc/os-release)";
if [ "${os_type}" = 'opensuse-leap' ]; then
  XIMFILE=/etc/X11/xim
  test -r $HOME/.xim && XIMFILE=$HOME/.xim
  test -r $XIMFILE && source $XIMFILE
fi

# Local startup script
if [ -r "$HOME/.xsession.local" ]; then
  . "$HOME/.xsession.local"
fi

# launches a session dbus instance
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ] && type dbus-launch >/dev/null; then
  eval `dbus-launch --sh-syntax --exit-with-session`
fi

# Start GNOME Keyring
if [ -n "$DESKTOP_SESSION" ] && command -v /usr/bin/gnome-keyring-daemon >/dev/null 2>&1; then
  eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
  export SSH_AUTH_SOCK
fi

# openbox
if command -v tint2 >/dev/null 2>&1; then
  echo $STARTUP | ( grep -q 'openbox-session' && tint2 & )
fi

get_session(){
  local dbus_args=(--sh-syntax --exit-with-session)
  case "$1" in
    awesome) dbus_args+=(awesome) ;;
    bspwm) dbus_args+=(bspwm-session) ;;
    budgie) dbus_args+=(budgie-desktop) ;;
    cinnamon) dbus_args+=(cinnamon-session) ;;
    deepin) dbus_args+=(startdde) ;;
    enlightenment) dbus_args+=(enlightenment_start) ;;
    fluxbox) dbus_args+=(startfluxbox) ;;
    gnome) dbus_args+=(gnome-session) ;;
    i3|i3wm) dbus_args+=(i3 --shmlog-size 0) ;;
    jwm) dbus_args+=(jwm) ;;
    kde) dbus_args+=(startplasma-x11) ;;
    lxde) dbus_args+=(startlxde) ;;
    lxqt) dbus_args+=(lxqt-session) ;;
    mate) dbus_args+=(mate-session) ;;
    xfce) dbus_args+=(xfce4-session) ;;
    openbox) dbus_args+=(openbox-session) ;;
    *) dbus_args+=("$1") ;;
  esac

  echo "dbus-launch ${dbus_args[*]}"
}

exec $(get_session "$SESSION")
#exec $STARTUP
#exec /usr/bin/ssh-agent $STARTUP

# if we got here, then exec failed
exit 1

# vim:ft=sh:sw=2:
