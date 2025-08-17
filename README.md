# Light Theme Development Environment Configuration

A cohesive light-themed development environment using Catppuccin Latte theme across tmux, neovim, lazygit, and alacritty.

## Overview

This configuration provides:
- **Tmux**: Light theme with Catppuccin Latte, proper pane styling, and TPM plugin management
- **Neovim**: Modern plugin setup with Lazy.nvim, Catppuccin theme, and LazyGit integration  
- **LazyGit**: Light theme with git-delta integration for beautiful diffs
- **Alacritty**: Terminal with JetBrainsMono Nerd Font and light theme
- **Git Delta**: Enhanced diff viewer with light theme syntax highlighting

## Prerequisites

```bash
# Install required tools
brew install tmux neovim lazygit git-delta alacritty

# Install JetBrainsMono Nerd Font
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
```

## Installation

1. **Clone and backup existing configs** (if any):
```bash
mv ~/.tmux.conf ~/.tmux.conf.backup 2>/dev/null || true
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null || true
mv ~/.config/lazygit ~/.config/lazygit.backup 2>/dev/null || true
mv ~/.config/alacritty ~/.config/alacritty.backup 2>/dev/null || true
```

2. **Copy configurations**:
```bash
cp .tmux.conf ~/.tmux.conf
cp -r .config/* ~/.config/
```

3. **Install Tmux Plugin Manager (TPM)**:
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

4. **Install tmux plugins**:
```bash
# Start tmux and press prefix + I (Ctrl-q + I) to install plugins
tmux new-session -d
tmux send-keys 'C-q I' Enter
tmux kill-session
```

5. **Configure git delta** (apply settings from git-delta-config.txt):
```bash
git config --global core.pager delta
git config --global interactive.difffilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.light true
git config --global delta.side-by-side true
git config --global delta.line-numbers true
git config --global delta.syntax-theme GitHub
```

6. **Install Neovim plugins**:
```bash
nvim --headless -c 'autocmd User LazyDone quitall' -c 'Lazy! sync'
```

## Configuration Details

### Tmux (.tmux.conf)
- **Theme**: Catppuccin Latte light theme
- **Plugin Manager**: TPM with catppuccin/tmux and tmux-resurrect
- **Pane Styling**: Light gray background for inactive panes, white for active
- **Borders**: Purple active borders, light gray inactive borders
- **Prefix**: Changed to Ctrl-q

### Neovim (.config/nvim/)
- **Plugin Manager**: Lazy.nvim for modern plugin management
- **Theme**: Catppuccin Latte with proper current line highlighting
- **LazyGit Integration**: `<leader>lg` to open LazyGit in floating terminal
- **LSP**: Configured with defensive programming for missing dependencies

### LazyGit (.config/lazygit/config.yml)
- **Theme**: Catppuccin Latte colors throughout interface
- **Delta Integration**: Light theme git diffs with syntax highlighting
- **Enhanced Visibility**: Darker selection colors for better contrast
- **Key Bindings**: Vim-style navigation preserved

### Alacritty (.config/alacritty/alacritty.toml)
- **Font**: JetBrainsMono Nerd Font for proper icon rendering
- **Theme**: GitHub Light theme import
- **Opacity**: Full opacity with subtle padding

### Git Delta (git-delta-config.txt)
- **Light Theme**: GitHub syntax theme for code highlighting
- **Features**: Side-by-side diffs, line numbers, navigation support
- **Integration**: Works seamlessly with LazyGit and command line

## Key Features

- **Consistent Theming**: Catppuccin Latte across all tools
- **Enhanced Git Experience**: Delta provides beautiful, readable diffs
- **Proper Font Support**: Nerd Font ensures icons display correctly
- **Vim Integration**: LazyGit accessible directly from Neovim
- **Plugin Management**: TPM for tmux, Lazy.nvim for neovim

## Usage

- **Tmux**: Start with `tmux`, use Ctrl-q as prefix
- **LazyGit in Neovim**: Press `<leader>lg` to open LazyGit
- **Git Diffs**: All git operations use delta automatically
- **Plugin Updates**: 
  - Tmux: Ctrl-q + U
  - Neovim: `:Lazy update`

## Troubleshooting

- **Tmux plugins not working**: Ensure TPM is installed and run Ctrl-q + I
- **Neovim dark theme**: Verify no dark theme overrides in init.lua
- **LazyGit dark theme**: Check that delta uses `--light` flag
- **Missing icons**: Install JetBrainsMono Nerd Font
- **Git diff colors**: Ensure git config uses delta with light theme