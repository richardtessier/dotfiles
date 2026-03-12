function _fzf_search_ws --description "Search z history for Claude projects, open with given command"
    set -l cmd $argv[1]
    if not string length -q -- $cmd
        set cmd ws
    end

    set -l projects
    for line in (z --list | string match --regex --groups-only '^\S+ +(.+)$')
        if test -d "$line/.claude" -o -f "$line/CLAUDE.md"
            set -a projects $line
        end
    end

    set -l selected (printf '%s\n' $projects | _fzf_wrapper --no-multi --ansi \
        --prompt="Claude project> " \
        --preview='ls -la {} 2>/dev/null | head -20')

    if test -n "$selected"
        $cmd $selected
    end
end
