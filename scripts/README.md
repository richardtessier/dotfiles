# Scripts

Utility scripts used by AeroSpace, fish functions, and iTerm2. These are not stow-managed -- they are referenced by absolute path from other configs.

## AeroSpace Window Management

| Script                            | Description                                                                                                             |
| --------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `aerospace-ff-windows.sh`         | Lists windows in tab-separated format for fzf. Modes: `all`, `workspace`, `floating`, `iterm2`                          |
| `aerospace-ff-pick.sh`            | Window picker for iTerm2 Hotkey Window profile. Uses fzf with `tab` (All/iTerm2 toggle), `/` (Workspace/Floating cycle) |
| `aerospace-list-windows.sh`       | Simple window listing helper                                                                                            |
| `aerospace-list-workspaces.sh`    | Simple workspace listing helper                                                                                         |
| `aerospace_layout_all.sh`         | Set layout on all windows in workspace                                                                                  |
| `aerospace_all_in_tree.sh`        | Collect all floating windows into tree (tiles or accordion mode)                                                         |
| `aerospace_toggle_center.sh`      | Toggle centered floating layout                                                                                         |
| `aerospace_toggle_center_moom.sh` | Toggle centered floating layout via Moom                                                                                |

## iTerm2

| Script                     | Description                                                                                                                                 |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `iterm2-title-provider.py` | iTerm2 Python API AutoLaunch script. Provides custom tab titles via TitleProviderRPC and syncs window title bar to active tab on tab switch |

## Other

| Script                 | Description                       |
| ---------------------- | --------------------------------- |
| `osx_fast_keyboard.sh` | Set fast key repeat rate on macOS |

## Manual Setup Steps

### iTerm2 Title Provider

The `iterm2-title-provider.py` script requires manual setup:

1. **Enable Python API**: iTerm2 > Settings > General > Magic > Enable Python API
2. **Symlink the script**:
   ```bash
   ln -s ~/dotfiles/scripts/iterm2-title-provider.py \
     ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch/title_provider.py
   ```
3. **Configure the AI profile** (iTerm2 > Settings > Profiles > AI > General):
   - Title: select **"Project Title"** (registered by the script)
   - "Applications in terminal may change the title": leave **checked**
4. **Restart iTerm2** to load the AutoLaunch script

### iTerm2 Hotkey Window Picker

The `aerospace-ff-pick.sh` script runs as the command for an iTerm2 Hotkey Window profile:

1. Create a profile named **"WindowPicker"** (or similar)
2. Set Command to: `~/dotfiles/scripts/aerospace-ff-pick.sh`
3. Configure as a Hotkey Window (Keys > Hotkey Window > opt+tab or similar)
