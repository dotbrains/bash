# Installation Guide

Complete installation instructions for the Bash configuration framework.

## Prerequisites

### Required
- Bash 4.0 or later
- Git 2.x or later

### Optional (Recommended)
- [fzf](https://github.com/junegunn/fzf) - Fuzzy finder
- [Starship](https://starship.rs) - Cross-shell prompt
- [eza](https://github.com/eza-community/eza) - Modern ls replacement
- [zoxide](https://github.com/ajeetdsouza/zoxide) - Smart cd command
- [bat](https://github.com/sharkdp/bat) - cat with syntax highlighting
- [thefuck](https://github.com/nvbn/thefuck) - Command correction
- [lazygit](https://github.com/jesseduffield/lazygit) - Terminal UI for Git

## Standard Installation

### 1. Clone the Repository

```bash
# Clone with submodules
git clone --recursive https://github.com/dotbrains/bash.git ~/.config/bash
```

If you already cloned without `--recursive`:
```bash
cd ~/.config/bash
git submodule update --init --recursive
```

### 2. Backup Existing Configuration

```bash
# Backup existing bash_profile if it exists
[[ -f ~/.bash_profile ]] && mv ~/.bash_profile ~/.bash_profile.backup
[[ -f ~/.bashrc ]] && mv ~/.bashrc ~/.bashrc.backup
```

### 3. Create Symlink

```bash
# Link the new bash_profile
ln -s ~/.config/bash/bash_profile ~/.bash_profile

# Optional: Also link for .bashrc (for non-login shells)
ln -s ~/.config/bash/bash_profile ~/.bashrc
```

### 4. Create Required Directories

The configuration will automatically create these on first run, but you can create them manually:

```bash
mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}/bash"
mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/bash"
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/bash"
```

### 5. Reload Your Shell

```bash
source ~/.bash_profile
```

Or open a new terminal window.

## XDG Directory Configuration

This configuration respects the XDG Base Directory Specification:

### Default Locations

- **Config**: `$HOME/.config/bash/`
- **Data**: `$HOME/.local/share/bash/`
- **Cache**: `$HOME/.cache/bash/`
- **State**: `$HOME/.local/state/bash/` (bash history)

### Custom XDG Directories

If you want to use custom locations, set these variables **before** sourcing bash_profile:

```bash
export XDG_CONFIG_HOME="$HOME/my-config"
export XDG_DATA_HOME="$HOME/my-data"
export XDG_CACHE_HOME="$HOME/my-cache"
export XDG_STATE_HOME="$HOME/my-state"
```

## Installing Optional Dependencies

### macOS (Homebrew)

```bash
brew install fzf starship eza zoxide bat thefuck lazygit
```

### Linux (apt)

```bash
# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Starship
curl -sS https://starship.rs/install.sh | sh

# eza (via cargo)
cargo install eza

# zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# bat
sudo apt install bat

# thefuck
pip3 install thefuck

# lazygit
sudo add-apt-repository ppa:lazygit-team/release
sudo apt update
sudo apt install lazygit
```

## Customization

### Disabling Specific Features

To disable specific modules, comment them out in `bash_profile`:

```bash
# Source integrations
source_bash_files "${BASH_CONFIG_DIR}/integrations" \
    "bash-sensible.bash" \
    "fzf.bash" \
    "z-lua.bash" \
    # "thefuck.bash" \      # Disabled
    "emoji-log.bash" \
    "theme.bash" \
    "starship.bash"
```

### Adding Custom Configuration

Create a `custom.bash` file:

```bash
# ~/.config/bash/custom.bash
export MY_CUSTOM_VAR="value"
alias my_alias="command"

function my_function() {
    echo "Hello!"
}
```

Then source it in `bash_profile`:

```bash
# At the end of bash_profile
[[ -f "${BASH_CONFIG_DIR}/custom.bash" ]] && . "${BASH_CONFIG_DIR}/custom.bash"
```

## Troubleshooting

### Configuration not loading

1. Check that bash_profile is properly linked:
   ```bash
   ls -la ~/.bash_profile
   ```

2. Verify XDG variables:
   ```bash
   echo $XDG_CONFIG_HOME
   ```

3. Check for errors:
   ```bash
   bash -x ~/.bash_profile
   ```

### History not saving

Ensure the state directory exists:
```bash
mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}/bash"
```

Check `$HISTFILE`:
```bash
echo $HISTFILE
```

### Functions/aliases not available

Verify files are readable:
```bash
ls -la ~/.config/bash/functions/
ls -la ~/.config/bash/aliases/
```

## Uninstallation

```bash
# Remove symlinks
rm ~/.bash_profile
rm ~/.bashrc  # if linked

# Restore backups
mv ~/.bash_profile.backup ~/.bash_profile
mv ~/.bashrc.backup ~/.bashrc

# Remove configuration
rm -rf ~/.config/bash

# Clean up XDG directories (optional)
rm -rf ~/.local/state/bash
rm -rf ~/.local/share/bash
rm -rf ~/.cache/bash
```

## Migration from Old Configuration

If you're migrating from the old flat structure:

1. Your history will automatically migrate to the XDG location
2. Old `bash/bash_*` files are preserved in the `bash/` directory as backup
3. The old `bash_profile` is renamed to `bash_profile.old`

## Next Steps

- Read [FUNCTIONS.md](FUNCTIONS.md) for available shell functions
- Read [ALIASES.md](ALIASES.md) for all aliases
- Customize `core/exports.bash` for your environment variables
- Add your own scripts to `functions/` or `aliases/`
