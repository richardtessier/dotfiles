# Dotfiles

Personal dotfiles for macOS managed with [GNU Stow](https://www.gnu.org/software/stow/).

## System Requirements

- macOS 15.7+ (Sequoia)
- Homebrew package manager
- GNU Stow

## Repository Structure

```
~/dotfiles/
├── fish/          # Fish shell configuration
├── nvim/          # Neovim with LazyVim
├── git/           # Git global settings
├── vscode/        # Visual Studio Code settings
├── homebrew/      # Brewfile for package management
├── scripts/       # Utility scripts
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
stow fish nvim git vscode

# Or install them individually
stow fish
stow nvim
stow git
stow vscode
```

This creates symlinks:
- `~/.config/fish/` → `~/dotfiles/fish/.config/fish/`
- `~/.config/nvim/` → `~/dotfiles/nvim/.config/nvim/`
- `~/.gitignore_global` → `~/dotfiles/git/.gitignore_global`
- And so on...

### 6. Install Fish plugins

Fish plugins are managed with [Fisher](https://github.com/jorgebucaran/fisher):

```bash
# Fisher will be installed via Homebrew
# Install plugins listed in fish_plugins file
fisher update
```

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
stow fish nvim git vscode

# 6. Install Fish plugins
fisher update

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
- **Claude Code**: AI coding assistant
- **Neovide**: Neovim GUI

## Configuration Notes

### Fish Shell
- Custom keybindings for navigation (Ctrl+N/P for history, etc.)
- fzf integration for fuzzy finding
- iterm2 shell integration (disabled in Warp terminal)
- Plugins: fzf.fish, z (directory jumping)

### Neovim
- LazyVim distribution (preconfigured Neovim setup)
- Plugin management via Lazy.nvim
- Configuration in `~/dotfiles/nvim/.config/nvim/lua/`

### Git
- Global gitignore patterns

### VS Code
- Settings and keybindings synchronized

## Troubleshooting

### Stow conflicts
If stow complains about existing files:
```bash
# Backup the conflicting file first
mv ~/.config/fish/config.fish ~/.config/fish/config.fish.backup

# Then try stowing again
stow fish
```

### Fish plugins not loading
```bash
fisher update
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
