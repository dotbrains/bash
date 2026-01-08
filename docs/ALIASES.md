# Aliases Reference

Complete listing of all aliases provided by this configuration.

## Navigation

- `..` - Go up one directory (`cd ..`)
- `...` - Go up two directories (`cd ../..`)
- `....` - Go up three directories (`cd ../../..`)
- `cd..` - Alias for `cd ..` (typo-tolerant)

## System Operations

### Basic Commands
- `:q` - Exit shell (Vim-style)
- `q` - Exit shell
- `c` - Clear screen
- `ch` - Clear command history
- `m` - Man pages (shorthand)
- `path` - Display PATH entries (one per line)
- `+x` - Make file executable (`chmod +x`)

### Clipboard (Linux with xclip)
- `pbcopy` - Copy to clipboard (Linux equivalent of macOS pbcopy)
- `pbpaste` - Paste from clipboard (Linux equivalent of macOS pbpaste)

### Directory Listing

**With eza (modern ls):**
- `ls` - List files (via eza)
- `l` - List files in long format (`eza -l`)

**Standard:**
- `lsd` - List only directories
- `lsh` - List only hidden files

### File Operations

**Safer rm (if installed):**
- `rm` - Safe delete via `rip` or `trash` (if available)

### Search & Navigation

**With fzy (fuzzy finder):**
- `fzyf` - Fuzzy find files
- `fzyd` - Fuzzy find directories

**With zoxide:**
- `z` - Smart directory jumping

### Desktop Management (macOS/Linux)

**Lock Screen:**
- `afk` - Lock screen (macOS: CGSession, Linux: gnome-screensaver or dm-tool)

**Desktop Icons:**
- `hide-desktop-icons` - Hide desktop icons
- `show-desktop-icons` - Show desktop icons

## Networking

- `lip` - Get local IP address (macOS)
- `xip` - Get external IP address
- `wttr` - Get weather forecast (via wttr.in)

## Git

- `acp` - Add all, commit (verbose), and push in one command
- `lg` - Launch lazygit (if installed)
- `git` - Aliased to `hub` (if installed)

## Package Managers

### NPM (Node Package Manager)
- `npmi` - Install package globally (`npm i -g`)
- `npmr` - Uninstall package globally (`npm uninstall -g`)
- `npmls` - List global packages (`npm list -g --depth 0`)
- `npms` - Search for packages (`npm s`)
- `npmu` - Update npm to latest version

### Yarn
- `ya` - Add package (`yarn add`)
- `yr` - Remove package (`yarn remove`)
- `yu` - Update yarn and all packages

### Homebrew
- `brewd` - Run brew doctor
- `brewi` - Install package (`brew install`)
- `brewr` - Uninstall package (`brew uninstall`)
- `brews` - Search for packages (`brew search`)
- `brewu()` - Function: Update and upgrade brew (+ cask + mas on macOS)

### pip (Python 2)
- `pipi` - Install package (`pip install`)
- `pipr` - Uninstall package (`pip uninstall`)
- `pipls` - List installed packages
- `pips` - Search for packages
- `pipu` - Update pip, setuptools, and all packages

### pip3 (Python 3)
- `pip3i` - Install package (`pip3 install`)
- `pip3r` - Uninstall package (`pip3 uninstall`)
- `pip3ls` - List installed packages
- `pip3s` - Search for packages
- `pip3u` - Update pip3 and all packages

### Composer (PHP)
- `ci` - Install dependencies (`composer install`)
- `cr` - Remove package (`composer remove`)
- `cls` - List commands (`composer list`)
- `cs` - Search packages (`composer search`)
- `cu` - Self-update composer

## Piknik (Network Clipboard)

If piknik is installed:
- `pkc` - Copy from STDIN to clipboard
- `pkp` - Paste clipboard content
- `pkm` - Move clipboard content
- `pkz` - Delete clipboard content
- `pkpr` - Extract tar archive from clipboard

## Utilities

- `has` - Check presence of command line tools and their versions (via curl)
- `update` - Run fish shell update function (if fish and update.fish are available)

## Integration-Specific

### thefuck
If thefuck is installed, it adds command correction with `fuck` command.

### Emoji-log (Git Commits)
When loaded via integration:
- `gnew <message>` - 📦 NEW commit
- `gimp <message>` - 👌 IMPROVE commit
- `gfix <message>` - 🐛 FIX commit
- `grlz <message>` - 🚀 RELEASE commit
- `gdoc <message>` - 📖 DOC commit
- `gtst <message>` - 🤖 TEST commit
- `gbrk <message>` - ‼️ BREAKING commit
- `gtype` - Show emoji-log types

## Notes

### Conditional Aliases
Some aliases are only defined if their corresponding tools are installed:
- `eza` (modern ls) - Replaces ls commands
- `rip` or `trash` - Safer rm alternatives
- `hub` - Enhanced git CLI
- `lazygit` - Terminal UI for git
- `xclip` (Linux) - Clipboard operations
- `fzy` - Fuzzy finder
- `piknik` - Network clipboard
- `thefuck` - Command correction

### Platform-Specific
Some aliases behave differently on macOS vs Linux:
- `afk` (lock screen)
- `lip` (local IP - macOS only uses `ipconfig getifaddr en0`)
- Desktop icon management

### Functions as Aliases
Note that `brewu()` is technically a function (defined in the same file) rather than a true alias, but it's used like an alias.

## Customization

To add your own aliases:

1. Create a new file in `aliases/` directory:
   ```bash
   # ~/.config/bash/aliases/custom.bash
   alias myalias="my command"
   ```

2. Source it in `bash_profile`:
   ```bash
   source_bash_files "${BASH_CONFIG_DIR}/aliases" \
       # ... existing aliases ...\
       "custom.bash"
   ```

Or add aliases to existing category files in `aliases/` directory.

## See Also

- [FUNCTIONS.md](FUNCTIONS.md) - Complete function reference
- [INSTALLATION.md](INSTALLATION.md) - Setup and configuration guide
