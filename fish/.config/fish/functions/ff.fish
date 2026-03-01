function ff --description 'List aerospace windows with progressive filtering'
    set -l s ~/dotfiles/scripts/aerospace-ff-windows.sh

    $s all | _fzf_wrapper \
        --ansi \
        --delimiter='\t' \
        --with-nth=2.. \
        --nth=2.. \
        --tiebreak=begin,index \
        --prompt='All > ' \
        --header='/: cycle filter | ctrl-s: toggle sort | tab: All/iTerm2' \
        --bind='ctrl-s:toggle-sort' \
        --bind="enter:execute(aerospace focus --window-id {1})+abort" \
        --bind="tab:transform:bash -c '
            if [[ \$FZF_PROMPT == \"All > \" ]]; then
                echo \"change-prompt(iTerm2 > )+reload($s iterm2)\";
            else
                echo \"change-prompt(All > )+reload($s all)\";
            fi'" \
        --bind="/:transform:bash -c '
            if [[ \$FZF_PROMPT == \"All > \" ]]; then
                echo \"change-prompt(Workspace > )+reload($s workspace)\";
            elif [[ \$FZF_PROMPT == \"Workspace > \" ]]; then
                echo \"change-prompt(Floating > )+reload($s floating)\";
            else
                echo \"change-prompt(All > )+reload($s all)\";
            fi'"
end
