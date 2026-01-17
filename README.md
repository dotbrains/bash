# Bash Configuration

[![Lint](https://github.com/dotbrains/bash/actions/workflows/lint.yml/badge.svg)](https://github.com/dotbrains/bash/actions/workflows/lint.yml)

A modular, XDG Base Directory compliant Bash configuration framework with organized aliases, functions, and integrations.

## Features

- **XDG Base Directory Compliant**: Follows the XDG Base Directory Specification for clean, organized configuration
- **Modular Architecture**: Organized into logical categories (core, aliases, functions, integrations)
- **Extensive Aliases**: Quick shortcuts for navigation, system operations, networking, Git, and package managers
- **Powerful Functions**: 200+ shell functions for Git operations, file management, development workflows, and more
- **Third-Party Integrations**: Seamless integration with fzf, starship, thefuck, z.lua, and more
- **Cross-Platform**: Works on macOS and Linux

## Structure

```text
.
├── bash_profile          # Main entry point
├── core/                 # Core Bash configuration
│   ├── exports.bash      # Environment variables
│   ├── options.bash      # Shell options
│   ├── colors.bash       # Color configuration
│   ├── autocomplete.bash # Completion settings
│   └── keybindings.bash  # Custom key bindings
├── aliases/              # Command aliases by category
│   ├── navigation.bash   # Directory navigation
│   ├── system.bash       # System operations
│   ├── networking.bash   # Network utilities
│   ├── git.bash          # Git shortcuts
│   └── package-managers.bash # Package manager aliases
├── functions/            # Shell functions by category
│   ├── general.bash      # General utilities (editor, updates, history)
│   ├── file-operations.bash # File management (compress, extract, datauri)
│   ├── utilities.bash    # Additional utilities (transfer.sh, less, SSL, curl, lsof)
│   ├── piknik.bash       # Clipboard operations
│   ├── git.bash          # Git utilities (1680+ lines of Git magic)
│   ├── github.bash       # GitHub operations (browser integration)
│   ├── asciinema.bash    # Terminal recording
│   └── overmind.bash     # Process management
├── integrations/         # Third-party tool integrations
│   ├── bash-sensible.bash # Sensible Bash defaults
│   ├── fzf.bash          # Fuzzy finder
│   ├── z-lua.bash        # Smart directory jumping
│   ├── starship.bash     # Cross-shell prompt
│   ├── thefuck.bash      # Command correction
│   ├── emoji-log.bash    # Emoji-based Git commits
│   └── theme.bash        # Terminal theming
├── themes/               # Color themes
│   └── dir_colors        # LS_COLORS configuration (Nord theme)
└── docs/                 # Documentation
    ├── INSTALLATION.md   # Installation guide
    ├── FUNCTIONS.md      # Function reference
    └── ALIASES.md        # Alias reference
```

## Quick Start

### Installation

1. **Clone the repository:**
   ```bash
   git clone --recursive https://github.com/dotbrains/bash.git ~/.config/bash
   ```

2. **Link the profile:**
   ```bash
   ln -s ~/.config/bash/bash_profile ~/.bash_profile
   ```

3. **Reload your shell:**
   ```bash
   source ~/.bash_profile
   ```

See [docs/INSTALLATION.md](docs/INSTALLATION.md) for detailed installation instructions.

## XDG Compliance

This configuration adheres to the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html):

- **Configuration**: `${XDG_CONFIG_HOME:-$HOME/.config}/bash/`
- **Data**: `${XDG_DATA_HOME:-$HOME/.local/share}/bash/`
- **Cache**: `${XDG_CACHE_HOME:-$HOME/.cache}/bash/`
- **State** (history): `${XDG_STATE_HOME:-$HOME/.local/state}/bash/`

## Highlights

### Git Functions
- `ginfo` - Comprehensive repository overview
- `gld` - Log details for feature branch
- `gup` - Interactive upstream review & pull
- `gli` - Interactive commit browser
- `gh` - GitHub repository browser

### Aliases
- Navigation: `..`, `...`, `....`
- System: `ls` (via eza), `rm` (via rip/trash)
- Git: `acp` (add, commit, push), `lg` (lazygit)
- Package managers: Quick shortcuts for npm, yarn, brew, pip

### Integrations
- **Starship**: Beautiful, fast, minimal prompt
- **fzf**: Fuzzy finder for files and history
- **z.lua**: Smart directory jumping
- **thefuck**: Corrects command typos
- **Emoji-log**: Emoji-based Git commits

## Documentation

- **[Installation Guide](docs/INSTALLATION.md)** - Detailed setup instructions
- **[Functions Reference](docs/FUNCTIONS.md)** - Complete function documentation
- **[Aliases Reference](docs/ALIASES.md)** - All available aliases

## Requirements

- Bash 4.0+
- Git 2.x+
- Optional: fzf, starship, eza, zoxide, bat, thefuck

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues.

## License

MIT License - See LICENSE file for details

## Credits

- Inspired by various dotfile configurations across the community
- Uses [bash-sensible](https://github.com/mrzool/bash-sensible) for sensible defaults
- Nord theme for colors via [nordtheme/dircolors](https://github.com/nordtheme/dircolors)
- [Emoji-log](https://github.com/ahmadawais/Emoji-Log) for semantic Git commits
