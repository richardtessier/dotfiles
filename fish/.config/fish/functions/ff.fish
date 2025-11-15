function ff --description 'list aerospace windows and allows switching'
    aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
end
