# Functions Reference

Comprehensive reference for all shell functions provided by this configuration.

## General Utilities

### `e [file]`
Open file in default editor. If no file specified, opens editor at current path.

### `t2s <file> [spaces]`
Convert file from tab to space indentation. Default: 2 spaces.

### `cype <command>`
Identical to `type` command but with Bat syntax highlighting support.

### `u`
Update environment with latest software. Updates Linux apps, brew, npm, fish, pip, and their packages.

### `iso <source_path> <output_name>`
Build an ISO image from mounted volume (macOS only).

### `kilp <query> [signal]`
Kill errant/undesired process. Default signal: 15.

### `ghf [command] [number]`
Grep history for top ten commands and execute one. Interactive history search.

### `qt <search_term>`
Search for text within the current directory (excludes .git and node_modules).

### `mkd <directory>`
Create new directories and enter the first one.

## File Operations

### `hrfs <size>`
Convert number to human readable file size (e.g., 1024 → 1 KB).

### `gz <file>`
Get gzip information (gzipped file size + reduction size).

### `extract <file>`
Extract any type of compressed file (tar, zip, gz, bz2, etc.).

### `delete_files [pattern]`
Delete files matching pattern from current directory. Default: *.DS_Store.

### `datauri <file>`
Create data URI from a file.

### `is_running <process>`
Check if a certain process is running.

### `ppi [query] [geometry]`
Process phone images (resize and optimize). Default: *.jpg at 50%.

## Additional Utilities

### `transfer <file>`
Upload file to transfer.sh for easy sharing. Supports piping.

### `lessi <file>`
Inspect file interactively with less (follow mode + line numbers).

### `licensei <license> <why>`
Include license in global whitelist (License Finder).

### `licensea <library> <why>`
Add library to global approval list (License Finder).

### `sslc <domain>`
Create self-signed SSL certificate for domain.

### `curli <url>`
Inspect remote file with default editor (downloads temporarily).

### `curld <url>`
Curl with diagnostic information (timing, speed, status).

### `port <number>`
List file activity on given port (uses lsof).

## Git Operations

### Repository Management
- `gia` - Initialize/re-initialize all repositories in current directory
- `gafe` - Mark repository as safe for auto-loading project's bin/* on path
- `groot` - Change to repository root directory
- `ginfo` - Print comprehensive repository overview
- `gstats` - Answer statistics for current project
- `gstatsa` - Answer statistics for all projects in current directory

### Commits & History
- `ghurn` - Answer commit churn for project files (sorted highest to lowest)
- `gount` - Answer total number of commits for current project
- `gli` - List feature branch commits (interactive)
- `gld` - List commit details for current feature branch
- `ghow [commit] [difftool]` - Show commit details with optional diff
- `gile <file> <commit> [diff]` - Show file details for specific commit
- `gistory <file>` - View file commit history (interactive)
- `glameh <file> [lines]` - View file commit history for specific lines
- `guthorc [author]` - Answer total lines added/removed by author

### Stashing
- `gash [label]` - Create stash with label
- `gashl` - List all stashes
- `gashs [option]` - Show stash (interactive, optional diff)
- `gashp` - Pop stash (interactive)
- `gashd` - Drop stash (interactive)
- `gasha` - Answer stash count for all projects

### Branches
- `gbl` - List local and remote branch details
- `gblo [author]` - List branches owned by author
- `gbla` - List current branch for all projects
- `gbc <name>` - Create and switch to branch
- `gbf <name>` - Duplicate current branch with new name
- `gbs` - Switch between branches (interactive)
- `gbsa <name>` - Switch to branch for all projects
- `gbd` - Delete branch (interactive, local/remote)
- `gbdl <branch>` - Delete local branch
- `gbdr <branch>` - Delete remote branch
- `gbdm` - Delete all merged branches
- `gbr <name>` - Rename current branch

### Syncing
- `gup` - Fetch, review commits (optional diff), and pull (interactive)
- `gync` - Sync remote changes and delete pruned/merged branches
- `gpua` - Pull new changes for all projects
- `gucca` - Answer upstream commit count for all projects

### Staging & Committing
- `galla` - Add all file changes for all projects
- `gcb [label]` - Create breakpoint commit (empty commit)
- `gcfi` - Select commit to fix within feature branch (interactive)
- `gcff <file>` - Create commit fix for file
- `gcfp <sha> [-a]` - Create fixup commit, push, and copy URL
- `gcaa` - Commit changes for all projects (interactive)
- `gcap` - Commit and push for all projects (interactive)

### Pushing
- `gpob` - Push current branch to origin and set upstream tracking
- `gpa` - Push changes for all projects

### Rebasing
- `grbi [commits|label]` - Rebase commits interactively
- `grbq [commits]` - Quick rebase (skips editor)

### Tags
- `gtagr <version> <notes_path> [datetime]` - Rebuild tag (WARNING: Destructive)
- `gtagd <name>` - Delete local and remote tag

### Worktrees
- `gwa <name> <option>` - Add and switch to new worktree (d=detach, r=remote, l=local)
- `gwd` - Delete current Git worktree

### Remotes
- `gra <url> [name]` - Add and track remote repository

### Reset & Clean
- `gess [commits|sha]` - Reset soft (preserves changes)
- `gesh [commits|sha]` - Reset hard (DESTRUCTIVE!)
- `gesha [commits]` - Reset hard for all projects (DESTRUCTIVE!)
- `guke <file>` - Permanently erase file from history (UNRECOVERABLE!)
- `gleana` - Clean uncommitted files from all projects
- `glear` - Clear repository for packaging/shipping

### Maintenance
- `gvac` - Verify and clean objects for current project
- `gvaca` - Verify and clean objects for all projects

### Configuration
- `gseta <key> <value>` - Set config value for all projects
- `ggeta <key>` - Get config value for all projects
- `gunseta <key>` - Unset config value for all projects
- `gail` - Get user email for current project
- `gaila` - Get user email for all projects
- `gailsa <email>` - Set user email for all projects

### Activity Reports
- `gince <since> [until] [author]` - Summarized activity since date/time for all projects
- `gday` - Activity for current day (all projects)
- `gweek` - Activity for current week (all projects)
- `gmonth` - Activity for current month (all projects)
- `gsup` - Activity since yesterday (standup report)
- `gtail` - Commit history since last tag (copies to clipboard)
- `gtaila` - Commit count since last tag for all projects

## GitHub Operations

### `gh [option] [args]`
View GitHub details for current project. Opens in browser or copies URLs.

**Options:**
- `o` - Open repository
- `i` - Open issues
- `c [hash]` - Open commits (or specific commit)
- `f <file> [lines]` - Copy file URL
- `b [option]` - Open branches (c=current, d=diff, r=pull request)
- `t` - Open tags
- `r [number|l]` - Open pull requests (or specific PR, l=list)
- `w` - Open wiki
- `p` - Open pulse
- `g` - Open graphs
- `s` - Open settings
- `u [hash|l]` - Print/copy URL (or commit URL, l=last commit)

### `ghpra`
Open pull requests for all projects (non-master branches only).

## Piknik (Clipboard)

- `pko <content>` - Copy content to clipboard
- `pkf <file>` - Copy file content to clipboard
- `pkfr [dir]` - Send directory to clipboard as tar archive

## Asciinema (Terminal Recording)

### `cinr <label>`
Create new asciinema recording with label.

## Overmind (Process Management)

- `oms [port]` - Start processes (default port: 2990)
- `omc [process]` - Connect to running process (default: web)
- `omr [process]` - Restart running process (default: web)

## Notes

- Functions marked with `(all)` operate on all Git repositories in the current directory
- Interactive functions prompt for input or confirmation
- Functions marked **DESTRUCTIVE** or **UNRECOVERABLE** should be used with extreme caution
- Many Git functions use color-coded output (cyan for project names, red for warnings)

## Tips

### Git Workflow Examples

**Feature branch development:**
```bash
gbc feature-name      # Create and switch to feature branch
# ... make changes ...
gash "WIP"           # Stash changes
gup                  # Review and pull upstream changes
gashp                # Pop stash
gcfi                 # Fix specific commit interactively
grbi                 # Interactive rebase
gh b r               # Open pull request
```

**Daily standup:**
```bash
gsup                 # Show yesterday's commits
gsta                 # Check projects with uncommitted changes
```

**Release preparation:**
```bash
gtail                # Get commits since last tag
glear                # Clean and optimize repository
```

See also: [ALIASES.md](ALIASES.md) for quick command shortcuts.
