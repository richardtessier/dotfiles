function obs --description 'Open Obsidian to current project folder'
    set -l vault Rich
    set -l vault_root "/Users/richardtessier/Library/Mobile Documents/iCloud~md~obsidian/Documents/Rich"

    if set -q argv[1]
        set -l target "projects/$argv[1]/$argv[1]"
        open "obsidian://open?vault=$vault&file=$target"
        return
    end

    # Resolve current dir to vault-relative path
    set -l real_cwd (realpath $PWD)
    set -l real_vault (realpath $vault_root)

    if string match -q "$real_vault/*" $real_cwd
        set -l relative (string replace "$real_vault/" "" $real_cwd)
        set -l folder_name (basename $relative)
        open "obsidian://open?vault=$vault&file=$relative/$folder_name"
    else
        # Not in vault, just open Obsidian
        open -a Obsidian
    end
end
