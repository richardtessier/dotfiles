function ws --description 'Switch current iTerm2 workspace tabs to another project'
    set -l target_dir (string length -q -- $argv[1]; and echo $argv[1]; or echo $PWD)

    uv run --script ~/dotfiles/scripts/iterm2-switch-workspace.py $target_dir
end
