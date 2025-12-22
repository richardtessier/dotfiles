function checknetwork
    while true
        echo -n "Trying dig google.com..."
        set dnsanswer $(dig +time=1 +tries=1 +noall +answer google.com)
        string match -r -q '^google.com' $dnsanswer
        if test $status -ne 0
            echo "ERROR!"
            echo "$(date) dig error: $dnsanswer"
            echo "Logging network issue"
            netstat -at >~/tmp/logissues/netstat_$(date "+%Y%m%d_%H%M%S").log
            lognetworkissue
            break
        else
            echo -n done
        end
        echo -n "...waiting 10 secs"
        sleep 10
        echo "."
    end
end
