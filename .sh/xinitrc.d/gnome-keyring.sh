#!/usr/bin/sh
# to be sourced
# Start GNOME Keyring
if [ -n "$DESKTOP_SESSION" ] && command -v gnome-keyring-daemon >/dev/null 2>&1; then
  eval "$(gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)"
  export SSH_AUTH_SOCK
fi
