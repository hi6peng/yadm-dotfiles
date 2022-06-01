#!/usr/bin/sh
# to be sourced

# Allow local root user to run X applications, regardless of hostname changes
if [ -x /usr/bin/xhost ] ; then
    xhost +si:localuser:root >& /dev/null
fi
