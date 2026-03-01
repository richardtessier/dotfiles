function fish_prompt
    if test -n "$SSH_TTY"
        echo -n (set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
    end

    echo -n (set_color blue)(prompt_pwd)' '

    set_color -o
    if fish_is_root_user
        echo -n (set_color red)'# '
    end
    echo -n (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '
    set_color normal

    if test "$TERM_PROGRAM" = iTerm.app
        set -l folder (basename $PWD)
        set -l role (test -n "$ITERM2_TAB_ROLE"; and echo $ITERM2_TAB_ROLE; or echo Terminal)
        printf '\e]1337;SetUserVar=%s=%s\a' project (printf %s $folder | base64)
        printf '\e]1337;SetUserVar=%s=%s\a' tabRole (printf %s $role | base64)
    end
end
