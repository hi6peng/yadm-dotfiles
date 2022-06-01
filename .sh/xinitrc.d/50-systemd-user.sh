#!/usr/bin/sh
# to be sourced
systemctl --user import-environment XMODIFIERS GTK_IM_MODULE QT4_IM_MODULE QT_IM_MODULE CLUTTER_IM_MODULE
if command -v dbus-update-activation-environment >/dev/null 2>&1; then
  dbus-update-activation-environment XMODIFIERS GTK_IM_MODULE QT4_IM_MODULE QT_IM_MODULE CLUTTER_IM_MODULE
fi
