function exportlog
    set dateparam $argv[1]
    #echo $dateparam
    set enddate (date -j -v +60S -f "%Y-%m-%d %H:%M:%S" "+%Y-%m-%d %H:%M:%S" $dateparam)
    #echo $enddate
    set outputlog ~/tmp/logissues/exportlog_$(date -j -f "%Y-%m-%d %H:%M:%S" "+%Y%m%d_%H%M%S" $dateparam).log
    log show --start "$dateparam" --end "$enddate" >$outputlog
end
