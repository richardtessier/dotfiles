function lognetworkissue
    set startdate (date -v -30S "+%Y-%m-%d %H:%M:%S")
    echo "Waiting 30 seconds..."
    sleep 30
    set enddate (date "+%Y-%m-%d %H:%M:%S")
    set outputlog ~/tmp/logissues/networklog_$(date -j -f "%Y-%m-%d %H:%M:%S" "+%Y%m%d_%H%M%S" $startdate).log
    log show --start "$startdate" --end "$enddate" >$outputlog
    echo "Wrote log: $outputlog"
    echo -n $outputlog | fish_clipboard_copy
end
