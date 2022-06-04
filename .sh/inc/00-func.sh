# shellcheck disable=SC2009
defunct() {
  echo "Children:"
  ps -ef | head -n1
  ps -ef | grep "[d]efunct"
  echo "------------------------------"
  echo "Parents:"
  ppids="$(ps -ef | grep "[d]efunct" | awk '{ print $3 }')"
  if [ -n "$ppids" ];then
    echo "$ppids" | while read -r ppid; do
      ps -A | grep "$ppid"
    done
  fi
}

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1"      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
