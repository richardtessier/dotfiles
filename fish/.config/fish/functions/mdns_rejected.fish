function mdns_rejected
    set dateparam $argv[1]
    set duration $argv[2]
    # set dateparam (date "+%Y-%m-%d %H:%M:%S")
    # #echo $dateparam
    set startdate (date -j -v -$duration -f "%Y-%m-%d %H:%M:%S" "+%Y-%m-%d %H:%M:%S" $dateparam)
    #echo $enddate
    set outputlog ~/tmp/logissues/brokenpipe_$(date -j -f "%Y-%m-%d %H:%M:%S" "+%Y%m%d_%H%M%S" $dateparam).log
    echo "Showing mDNS broken pipe from" $startdate to $dateparam

    log show --start "$startdate" --end "$dateparam" --predicate '(process BEGINSWITH "nesession") && (eventMessage CONTAINS "Rejected")'
    #log show --start "$startdate" --end "$dateparam" --predicate '(eventMessage CONTAINS "Rejected")'
end
