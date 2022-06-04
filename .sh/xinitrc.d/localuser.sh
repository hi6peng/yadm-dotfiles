#!/usr/bin/sh
# to be sourced

[ -x /usr/bin/xhost ] && [ -x /usr/bin/id ] && \
  xhost +si:localuser:"$(id -un)"
