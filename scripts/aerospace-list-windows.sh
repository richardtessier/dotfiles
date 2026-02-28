scope="--all"
if [ "$1" = "--focused" ]; then
  scope="--workspace focused"
  shift
fi

aerospace list-windows $scope --format "%{app-pid}|%{window-id}|%{app-name}|%{window-title}" | grep -E -i "$1" | sed -r -e 's/[[:blank:]]*\|[[:blank:]]*/\|/g' -e 's/"/\\"/g' >"_listwindows.txt"

# echo "--- START: $1 ---"
# if [ -n "$DEBUG" ]; then
#   echo ""
#   echo "--- START: $1 ---"
#   echo ""
# fi

echo '{"items": ['

firstline=1
while IFS='|' read -r appid windowid name title; do
  if [ "$firstline" -eq 0 ]; then
    echo ","
  fi

  apppath="$(ps -o comm= -p "$appid")"
  bundlepath="${apppath%%\.app*}.app"

  echo "{
          \"arg\":\"$windowid\",
          \"uid\":\"$windowid\",
          \"title\":\"$title\",
          \"subtitle\":\"$name\",
          \"icon\": { 
            \"type\": \"fileicon\", 
            \"path\": \"$bundlepath\" 
          }
        }"
  firstline=0
done <"_listwindows.txt"

echo ']}'
exit
