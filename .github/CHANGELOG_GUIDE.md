# Changelog Maintenance Guide

This guide explains how to maintain the CHANGELOG.md file for this project.

## Format

We follow [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format with the following sections:

- **Added** - New features or functionality
- **Changed** - Changes in existing functionality
- **Deprecated** - Soon-to-be removed features
- **Removed** - Removed features
- **Fixed** - Bug fixes
- **Security** - Security-related changes

## Workflow

### During Development

1. **Add changes to the Unreleased section** as you make them:

   ```markdown
   ## [Unreleased]
   
   ### Added
   - New feature description
   
   ### Fixed
   - Bug fix description
   ```

2. **Be specific and user-focused** - Write what changed from the user's perspective, not implementation details.

3. **Group related changes** - If multiple commits relate to one feature, summarize them as a single entry.

### Preparing for a Release

1. **Create a new version section** below the Unreleased section:

   ```markdown
   ## [Unreleased]
   
   ## [v1.0.0] - 2024-01-15
   
   ### Added
   - Feature from unreleased section
   ```

2. **Move changes from Unreleased** to the new version section.

3. **Keep Unreleased section empty** (or with new changes made after the release).

4. **Add version comparison links** at the bottom:

   ```markdown
   [Unreleased]: https://github.com/OWNER/REPO/compare/v1.0.0...HEAD
   [v1.0.0]: https://github.com/OWNER/REPO/releases/tag/v1.0.0
   ```

### Release Process

When you create a release tag (e.g., `v1.0.0`):

1. The GitHub Actions workflow will automatically:
   - Extract the changelog section for that version
   - Include it in the GitHub Release notes
   - Fall back to the Unreleased section if version-specific section doesn't exist

2. After the release:
   - Create a new Unreleased section at the top
   - Start documenting new changes there

## Examples

### Good Changelog Entries

✅ `Added support for custom colorschemes`
✅ `Fixed shell integration with Nushell 0.109+`
✅ `Changed installation method from cargo to Linuxbrew`
✅ `Removed deprecated filesize configuration option`

### Bad Changelog Entries

❌ `Updated config.nu` (too vague)
❌ `Fixed bug in line 42` (implementation detail)
❌ `Refactored code` (not user-facing)
❌ `Changed stuff` (not descriptive)

## Tips

- **Commit early, update often** - Update the changelog as you make changes, not all at once before release
- **Link to issues/PRs** when relevant - `Fixed shell integration (#123)`
- **Use semantic versioning** - Breaking changes = major version, new features = minor version, bug fixes = patch version
- **Keep it concise** - Users want to quickly understand what changed, not read a novel
