defunct() {
  echo "Children:"
  ps -ef | head -n1
  ps -ef | grep [d]efunct
  echo "------------------------------"
  echo "Parents:"
  ppids="$(ps -ef | grep [d]efunct | awk '{ print $3 }')"
  if [ ! -z "$ppids" ];then
    echo "$ppids" | while read ppid; do
      ps -A | grep "$ppid"
    done
  fi
}
