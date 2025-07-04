# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Configuration Architecture

This is a minimal Neovim configuration using lazy.nvim as the plugin manager. The configuration follows a modular structure:

- `init.lua` - Entry point that loads the lazy plugin manager and sets basic options
- `lua/config/lazy.lua` - Lazy.nvim bootstrap and main plugin specification
- `lua/config/plugins/` - Individual plugin configurations organized by functionality

### Plugin Management

The configuration uses lazy.nvim for plugin management with the following structure:
- Plugins are defined in `lua/config/lazy.lua` with inline configurations for simple setups
- More complex plugin configurations are modularized in `lua/config/plugins/`
- Plugin imports use the pattern `{ import = "config.plugins" }` to automatically load all files in the plugins directory

### Key Bindings

Core keybindings are set in `init.lua`:
- `<space><space>x` - Source current file
- `<space>x` - Execute current line as Lua (normal mode)
- `<space>x` - Execute selection as Lua (visual mode)
- Leader key is set to space character

### Current Plugins

- **tokyonight.nvim** - Tokyo Night colorscheme (storm variant)
- **mini.nvim** - Minimal statusline configuration

## Development Commands

### Plugin Management
```bash
# Install/update plugins (run inside Neovim)
:Lazy

# Check plugin status
:Lazy check

# Update plugins
:Lazy update

# Clean unused plugins
:Lazy clean
```

### Configuration Testing
```bash
# Reload configuration
nvim
# Then use <space><space>x to source current file

# Test Lua code
# Select code and use <space>x in visual mode
# Or use <space>x on current line in normal mode
```

## Configuration Patterns

When adding new plugins:
1. For simple plugins, add directly to the spec in `lua/config/lazy.lua`
2. For complex configurations, create a new file in `lua/config/plugins/`
3. Plugin files should return a table with plugin specifications
4. Use lazy loading where appropriate to improve startup time

The configuration emphasizes simplicity and uses lazy.nvim's modern plugin specification format.