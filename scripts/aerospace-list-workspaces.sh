aerospace list-workspaces --all | grep -i "$1" | sed -r -e 's/[[:blank:]]*\|[[:blank:]]*/\|/g' -e 's/"/\\"/g' >"_listworkspaces.txt"
echo '{"items": ['

firstline=1
while IFS='|' read -r workspacename; do
  if [ "$firstline" -eq 0 ]; then
    echo ","
  fi
  echo "{"
  echo "\"arg\":\"$workspacename\","
  echo "\"uid\":\"$workspacename\","
  echo "\"title\":\"$workspacename\""
  echo "}"
  firstline=0
done <"_listworkspaces.txt"

echo ']}'
exit
