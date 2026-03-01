# Dotfiles

Personal dotfiles for macOS managed with [GNU Stow](https://www.gnu.org/software/stow/).

## System Requirements

- macOS 15.7+ (Sequoia)
- Homebrew package manager
- GNU Stow

## Repository Structure

```
~/dotfiles/
├── aerospace/     # AeroSpace window manager configuration
├── claude/        # Claude Code settings
├── fish/          # Fish shell configuration
├── gh/            # GitHub CLI configuration
├── git/           # Git global settings
├── homebrew/      # Brewfile for package management
├── lazygit/       # Lazygit terminal UI configuration
├── nvim/          # Neovim with LazyVim
├── vscode/        # Visual Studio Code settings (optional)
├── scripts/       # Utility scripts (not stow-managed, see scripts/README.md)
└── archive/       # Old/deprecated configs (not used)
```

Each directory is a "stow package" that contains files organized in their target directory structure. When you run `stow`, it creates symlinks from your home directory to the files in these packages.

## Initial Setup

### 1. Install Homebrew (if not already installed)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Clone this repository

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
```

### 3. Install packages from Brewfile

```bash
cd ~/dotfiles/homebrew
brew bundle install
```

This will install:
- GNU Stow (dotfiles management)
- Fish shell
- Neovim
- All other tools and applications

### 4. Set Fish as your default shell

```bash
echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
```

### 5. Stow your dotfiles

From the `~/dotfiles` directory, run:

```bash
# Install all packages at once
stow fish nvim git aerospace gh lazygit claude

# Or install them individually
stow fish
stow nvim
stow git
stow aerospace
stow gh
stow lazygit
stow claude
```

This creates symlinks:
- `~/.config/fish/` → `~/dotfiles/fish/.config/fish/`
- `~/.config/nvim/` → `~/dotfiles/nvim/.config/nvim/`
- `~/.config/aerospace/` → `~/dotfiles/aerospace/.config/aerospace/`
- `~/.config/gh/` → `~/dotfiles/gh/.config/gh/`
- `~/.config/lazygit/` → `~/dotfiles/lazygit/.config/lazygit/`
- `~/.claude/` → `~/dotfiles/claude/.claude/`
- `~/.gitconfig` → `~/dotfiles/git/.gitconfig`
- `~/.gitignore_global` → `~/dotfiles/git/.gitignore_global`
- And so on...

**Note:** If you use VS Code, you can also `stow vscode` to sync your settings and keybindings.

### 6. Fish plugins

Fish plugins ([fzf.fish](https://github.com/patrickf1/fzf.fish) and [z](https://github.com/jethrokuan/z)) are already included in the repository and will be available after stowing the fish configuration. No additional installation is needed.

### 7. Set up Neovim

LazyVim will automatically install plugins on first launch:

```bash
nvim
```

Wait for all plugins to install, then restart Neovim.

## Usage

### Adding New Dotfiles

1. Create a new package directory:
   ```bash
   mkdir -p ~/dotfiles/myapp/.config/myapp
   ```

2. Move your config file:
   ```bash
   mv ~/.config/myapp/config.yml ~/dotfiles/myapp/.config/myapp/
   ```

3. Stow the package:
   ```bash
   cd ~/dotfiles
   stow myapp
   ```

### Removing/Unstowing Dotfiles

```bash
cd ~/dotfiles
stow -D fish  # Removes symlinks for fish package
```

### Updating Dotfiles

Since your configs are symlinked, any changes you make to files in `~/.config/fish/config.fish` (for example) automatically update `~/dotfiles/fish/.config/fish/config.fish`. Just commit and push:

```bash
cd ~/dotfiles
git add -A
git commit -m "Update fish config"
git push
```

### Updating Brewfile

When you install new packages via Homebrew, update the Brewfile:

```bash
cd ~/dotfiles/homebrew
brew bundle dump --force --describe
git add Brewfile
git commit -m "Update Brewfile"
```

### Restoring on a New Machine

```bash
# 1. Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Clone dotfiles
git clone <your-repo-url> ~/dotfiles

# 3. Install packages
cd ~/dotfiles/homebrew
brew bundle install

# 4. Change shell to Fish
echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish

# 5. Stow dotfiles
cd ~/dotfiles
stow fish nvim git aerospace gh lazygit claude

# 6. Set up iTerm2 scripts (see scripts/README.md)
ln -s ~/dotfiles/scripts/iterm2-title-provider.py \
  ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch/title_provider.py

# 7. Launch Neovim to install plugins
nvim
```

## Installed Tools

### Shell & Terminal
- **Fish**: User-friendly shell with excellent defaults
- **Fisher**: Fish plugin manager
- **fzf**: Fuzzy finder
- **z**: Directory jumping (via jethrokuan/z)

### Editors
- **Neovim**: Modern Vim fork with LazyVim distribution

### Development Tools
- **git**: Version control
- **git-delta**: Better diff viewer
- **lazygit**: Terminal UI for git
- **ripgrep**: Fast text search
- **fd**: Fast alternative to find
- **bat**: Cat with syntax highlighting

### Window Management
- **AeroSpace**: i3-like tiling window manager for macOS

### Applications
- **iTerm2**: Terminal emulator with Python API for scripting
- **Claude Code**: AI coding assistant
- **Neovide**: Neovim GUI

## Configuration Notes

### Fish Shell
- Custom keybindings for navigation (Ctrl+N/P for history, etc.)
- fzf integration for fuzzy finding
- iTerm2 shell integration (disabled in Warp terminal)
- Plugins: fzf.fish, z (directory jumping)
- `ws` function: opens an iTerm2 work session with Claude Code + Terminal tabs
- `ff` function: fuzzy window picker with filter modes (All/iTerm2/Workspace/Floating)
- Dynamic iTerm2 tab titles via `SetUserVar` escape sequences in `fish_prompt`

### Neovim
- LazyVim distribution (preconfigured Neovim setup)
- Plugin management via Lazy.nvim
- Configuration in `~/dotfiles/nvim/.config/nvim/lua/`

### AeroSpace
- i3-like tiling window manager for macOS
- Configuration in `~/dotfiles/aerospace/.config/aerospace/aerospace.toml`
- Custom keybindings for workspace/window management, resize mode, layout toggling
- Window picker via iTerm2 Hotkey Window (`aerospace-ff-pick.sh`)

### iTerm2
- **Title Provider** (`scripts/iterm2-title-provider.py`): Python API script that renders tab titles from `user.project` and `user.tabRole` variables, and syncs window title to active tab
- **Work Sessions** (`ws` fish function): opens a 2-tab iTerm2 window (Claude Code + Terminal) with project-aware titles
- Requires manual setup -- see `scripts/README.md`

### Claude Code
- Settings and configuration synced via stow

### GitHub CLI (gh)
- Git protocol set to HTTPS
- Custom alias: `gh co` for `gh pr checkout`

### Lazygit
- Terminal UI for git commands
- Configuration in `~/dotfiles/lazygit/.config/lazygit/config.yml`

### Git
- Global gitignore patterns
- Configuration includes `.gitconfig` and `.gitignore_global`

### VS Code (Optional)
- Settings and keybindings synchronized
- Only stow if you use VS Code

## Troubleshooting

### Stow conflicts
If stow complains about existing files:
```bash
# Backup the conflicting file first
mv ~/.config/fish/config.fish ~/.config/fish/config.fish.backup

# Then try stowing again
stow fish
```

### Neovim plugins not installing
```bash
# Inside Neovim
:Lazy sync
```

## Archive

The `archive/` directory contains old configuration files from previous setups:
- `zshrc`: Old ZSH configuration (replaced by Fish)
- `vimrc`: Old Vim configuration (replaced by Neovim/LazyVim)
- `z.sh`: Old Z script for ZSH (replaced by Fish version)
- `tmux/`: Old tmux configuration (no longer used)
- `karabiner/`: Old Karabiner Elements configuration (no longer used)
- `init.lua.old`: Legacy Neovim config

These are kept for reference but are not used.

## License

Feel free to use these dotfiles as inspiration for your own setup!
