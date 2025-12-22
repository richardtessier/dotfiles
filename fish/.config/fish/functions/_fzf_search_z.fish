function _fzf_search_z --description "Search the z directory history. Replace the current token with the selected file paths."
    # --string-cwd-prefix prevents fd >= 8.3.0 from prepending ./ to relative paths
    set fzf_arguments --multi --ansi $fzf_dir_opts
    set token (commandline --current-token)
    # expand any variables or leading tilde (~) in the token
    #set expanded_token (eval echo -- $token)
    set directory_selected (z --list $token | string match --regex --groups-only "^[0-9.]+ +(.+)\$" | _fzf_wrapper $fzf_arguments)
    commandline --current-token --replace (string escape $directory_selected)
    commandline --function repaint
end
