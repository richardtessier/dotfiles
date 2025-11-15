if status is-interactive
    # Commands to run in interactive sessions can go here
    bind -M insert \cn down-or-search
    bind -M insert \cp up-or-search
    bind -M insert \ck undo
    bind -M insert \ct forward-char
    bind -M insert \cq edit_command_buffer
    if test "$TERM_PROGRAM" != WarpTerminal
        source ~/.iterm2_shell_integration.fish
    end
    fzf_configure_bindings --directory=\cf
    test -n \cz && bind --mode insert \cz _fzf_search_z
end
