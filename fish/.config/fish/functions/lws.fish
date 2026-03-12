function lws --description 'Launch new iTerm2 work session with Claude + Terminal tabs'
    set -l target_dir (string length -q -- $argv[1]; and echo $argv[1]; or echo $PWD)

    uv run --script ~/dotfiles/scripts/iterm2-launch-workspace.py $target_dir
end
