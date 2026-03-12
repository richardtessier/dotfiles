function lws --description 'Launch new iTerm2 work session with Claude + Terminal tabs'
    # set -l target_dir (realpath (string length -q -- $argv[1]; and echo $argv[1]; or echo $PWD))
    set -l target_dir (string length -q -- $argv[1]; and echo $argv[1]; or echo $PWD)
    set -l project (basename $target_dir)
    set -l b64project (printf %s $project | base64)
    set -l b64claude (printf %s Claude | base64)
    set -l b64terminal (printf %s Terminal | base64)

    set -l setproject "printf '\\\\e]1337;SetUserVar=project=$b64project\\\\a'"
    set -l cmd1 "cd '$target_dir' && set -gx ITERM2_TAB_ROLE Claude && $setproject && printf '\\\\e]1337;SetUserVar=tabRole=$b64claude\\\\a' && claude"
    set -l cmd2 "cd '$target_dir' && set -gx ITERM2_TAB_ROLE Terminal && $setproject && printf '\\\\e]1337;SetUserVar=tabRole=$b64terminal\\\\a'"

    set -l tmpscript (mktemp /tmp/ws-XXXXXX.scpt)
    printf '%s\n' \
        'tell application "iTerm2"' \
        '    activate' \
        '    set newWindow to (create window with profile "AI")' \
        '    tell current session of current tab of newWindow' \
        "        write text \"$cmd1\"" \
        '    end tell' \
        '    tell newWindow' \
        '        set newTab to (create tab with profile "AI")' \
        '    end tell' \
        '    tell current session of current tab of newWindow' \
        "        write text \"$cmd2\"" \
        '    end tell' \
        '    tell newWindow' \
        '        select tab 1' \
        '    end tell' \
        'end tell' >$tmpscript

    osascript $tmpscript
    rm -f $tmpscript

    # Launch Obsidian if not running
    if not pgrep -xq Obsidian
        open -a Obsidian
    end
end
