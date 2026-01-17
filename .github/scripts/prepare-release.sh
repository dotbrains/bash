#!/usr/bin/env bash

# Script to prepare a new release by updating the CHANGELOG.md
# Usage: ./prepare-release.sh <version>
# Example: ./prepare-release.sh v1.0.0

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 v1.0.0"
    exit 1
fi

VERSION="$1"
DATE=$(date +%Y-%m-%d)
CHANGELOG="CHANGELOG.md"

# Remove 'v' prefix if present for display
VERSION_NUMBER="${VERSION#v}"

# Check if CHANGELOG.md exists
if [ ! -f "$CHANGELOG" ]; then
    echo "❌ Error: CHANGELOG.md not found"
    exit 1
fi

# Check if Unreleased section exists
if ! grep -q "## \[Unreleased\]" "$CHANGELOG"; then
    echo "❌ Error: No [Unreleased] section found in CHANGELOG.md"
    exit 1
fi

# Check if the version already exists
if grep -q "## \[$VERSION_NUMBER\]" "$CHANGELOG" || grep -q "## $VERSION" "$CHANGELOG"; then
    echo "⚠️  Warning: Version $VERSION already exists in CHANGELOG.md"
    read -p "Do you want to continue? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Create a temporary file
TMP_FILE=$(mktemp)

# Process the changelog
awk -v version="$VERSION_NUMBER" -v date="$DATE" '
    /^## \[Unreleased\]/ {
        print $0
        print ""
        print "## [" version "] - " date
        next
    }
    { print }
' "$CHANGELOG" > "$TMP_FILE"

# Replace the original file
mv "$TMP_FILE" "$CHANGELOG"

echo "✅ Successfully prepared release $VERSION in CHANGELOG.md"
echo ""
echo "Next steps:"
echo "1. Review the changes in CHANGELOG.md"
echo "2. Commit the changes: git add CHANGELOG.md && git commit -m 'Prepare release $VERSION'"
echo "3. Create and push the tag: git tag $VERSION && git push origin $VERSION"
echo "4. The GitHub Actions workflow will automatically create the release"
