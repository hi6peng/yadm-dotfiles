#!/bin/sh
# shellcheck disable=SC2034
# pip install --user https://github.com/shadowsocks/shadowsocks/archive/master.zip -U
#./shadowsocks-local-linux64-1.1.4 -c ssconfig-vps.json &
export PATH=$HOME/.local/bin:$PATH

script_dir="$( cd "$( dirname "$0" )" && pwd )"
script_filename="$(basename "$0")"

APPDIR=~/.config/ss
[ ! -d ~/.run ] && mkdir -p ~/.run
[ ! -d ~/.log ] && mkdir -p ~/.log

case "$1" in
start)
    sslocal -c $APPDIR/ssconfig-just.json --pid-file ~/.run/ssc.pid --log-file ~/.log/ssc.log -d start
    ;;
stop)
    sslocal -c $APPDIR/ssconfig-just.json --pid-file ~/.run/ssc.pid --log-file ~/.log/ssc.log -d stop
    ;;
*)
    echo "Usages: $0 {start|stop}" >&2
    exit 2
    ;;
esac
