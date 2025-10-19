#!/usr/bin/env bash
set -euo pipefail

# Simple release helper for Dirfy
# Usage: ./scripts/release.sh X.Y.Z

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <version>"
  exit 2
fi

VERSION="$1"

echo "Bumping version to ${VERSION}"
perl -0777 -pe "s/(VERSION = \")([0-9.]+)(\")/\1${VERSION}\3/s" -i lib/dirfy/version.rb

echo "Installing dependencies and running tests"
bundle install
bundle exec rake

echo "Building gem"
bundle exec rake build

echo "Committing and tagging"
git add lib/dirfy/version.rb
git commit -m "chore: release v${VERSION}" || true
git tag "v${VERSION}"

echo "Push tags to origin (this will trigger CI if configured)"
git push origin main --follow-tags

echo "Gem built at pkg/dirfy-${VERSION}.gem"
echo "To publish the gem interactively (handles 2FA), run:" \
     && echo "  gem push pkg/dirfy-${VERSION}.gem"

echo "Done"
#!/bin/bash#!/usr/bin/env bash

# Release helper script for dirfy gem# Release script for dirfy gem

# Usage: ./scripts/release.sh [patch|minor|major]set -e



set -e# Colors for output

RED='\033[0;31m'

# Colors for outputGREEN='\033[0;32m'

RED='\033[0;31m'YELLOW='\033[1;33m'

GREEN='\033[0;32m'NC='\033[0m' # No Color

YELLOW='\033[1;33m'

NC='\033[0m' # No Color# Helper functions

log() { echo -e "${GREEN}[INFO]${NC} $1"; }

# Helper function for colored outputwarn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

log() {error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

    echo -e "${GREEN}[RELEASE]${NC} $1"

}# Check if version argument provided

if [ $# -eq 0 ]; then

warn() {    error "Usage: $0 <version> [release-notes]"

    echo -e "${YELLOW}[WARNING]${NC} $1"fi

}

VERSION=$1

error() {RELEASE_NOTES=${2:-"Release v$VERSION"}

    echo -e "${RED}[ERROR]${NC} $1"

    exit 1log "Starting release process for version $VERSION"

}

# Validate version format

# Check if version type is providedif ! [[ $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then

if [ $# -eq 0 ]; then    error "Version must be in format X.Y.Z (e.g., 1.2.3)"

    error "Usage: $0 [patch|minor|major]"fi

fi

# Check if working directory is clean

VERSION_TYPE=$1if ! git diff-index --quiet HEAD --; then

    error "Working directory is not clean. Please commit or stash changes."

# Validate version typefi

if [[ "$VERSION_TYPE" != "patch" && "$VERSION_TYPE" != "minor" && "$VERSION_TYPE" != "major" ]]; then

    error "Invalid version type. Use: patch, minor, or major"# Check if on main branch

fiBRANCH=$(git rev-parse --abbrev-ref HEAD)

if [ "$BRANCH" != "main" ]; then

# Check if we're in a git repository    warn "Not on main branch (currently on $BRANCH). Continue? [y/N]"

if ! git rev-parse --git-dir > /dev/null 2>&1; then    read -r response

    error "Not in a git repository"    if [[ ! "$response" =~ ^[Yy]$ ]]; then

fi        error "Aborted by user"

    fi

# Check if working directory is cleanfi

if ! git diff --quiet || ! git diff --cached --quiet; then

    error "Working directory is not clean. Please commit or stash changes."# Update version in file

filog "Updating version to $VERSION"

sed -i.bak "s/VERSION = \".*\"/VERSION = \"$VERSION\"/" lib/dirfy/version.rb

# Get current versionrm lib/dirfy/version.rb.bak

CURRENT_VERSION=$(ruby -r "./lib/dirfy/version" -e "puts Dirfy::VERSION")

log "Current version: $CURRENT_VERSION"# Run tests

log "Running tests..."

# Calculate new versionbundle exec rake || error "Tests failed"

IFS='.' read -r -a version_parts <<< "$CURRENT_VERSION"

major=${version_parts[0]}# Commit version change

minor=${version_parts[1]}log "Committing version change"

patch=${version_parts[2]}git add lib/dirfy/version.rb Gemfile.lock

git commit -m "chore: bump version to v$VERSION"

case $VERSION_TYPE in

    "major")# Create and push tag

        major=$((major + 1))log "Creating and pushing tag v$VERSION"

        minor=0git tag "v$VERSION"

        patch=0git push origin main

        ;;git push origin "v$VERSION"

    "minor")

        minor=$((minor + 1))# Build gem

        patch=0log "Building gem"

        ;;rake build

    "patch")

        patch=$((patch + 1))# Create GitHub release

        ;;log "Creating GitHub release"

esacif command -v gh &> /dev/null; then

    gh release create "v$VERSION" "pkg/dirfy-$VERSION.gem" \

NEW_VERSION="$major.$minor.$patch"        --title "v$VERSION" \

log "New version will be: $NEW_VERSION"        --notes "$RELEASE_NOTES"

else

# Confirm release    warn "GitHub CLI (gh) not found. Please create release manually at:"

read -p "Continue with release $NEW_VERSION? (y/N) " -n 1 -r    warn "https://github.com/ahmedmelhady7/dirfy/releases/new?tag=v$VERSION"

echofi

if [[ ! $REPLY =~ ^[Yy]$ ]]; then

    log "Release cancelled"# Instructions for RubyGems

    exit 0log "Release process complete!"

filog "To publish to RubyGems, run:"

log "  gem push pkg/dirfy-$VERSION.gem"

# Update version filelog ""

log "Updating version file..."log "Verify the release:"

sed -i.bak "s/VERSION = \"$CURRENT_VERSION\"/VERSION = \"$NEW_VERSION\"/" lib/dirfy/version.rblog "  gem install dirfy"

rm lib/dirfy/version.rb.baklog "  dirfy --version"

# Run tests
log "Running tests..."
if ! bundle exec rake; then
    error "Tests failed. Aborting release."
fi

# Commit version bump
log "Committing version bump..."
git add lib/dirfy/version.rb Gemfile.lock
git commit -m "chore: bump version to v$NEW_VERSION"

# Create and push tag
log "Creating and pushing tag v$NEW_VERSION..."
git tag "v$NEW_VERSION"
git push origin main
git push origin "v$NEW_VERSION"

# Build gem
log "Building gem..."
rake build

# Publish to RubyGems
log "Publishing to RubyGems..."
warn "You may need to complete 2FA authentication in your browser"
gem push "pkg/dirfy-$NEW_VERSION.gem"

# Create GitHub release
if command -v gh &> /dev/null; then
    log "Creating GitHub release..."
    gh release create "v$NEW_VERSION" "pkg/dirfy-$NEW_VERSION.gem" \
        --title "v$NEW_VERSION" \
        --generate-notes
else
    warn "GitHub CLI (gh) not found. Please create the GitHub release manually:"
    warn "https://github.com/ahmedmelhady7/dirfy/releases/new?tag=v$NEW_VERSION"
fi

log "Release v$NEW_VERSION completed successfully! 🎉"
log "Gem published to: https://rubygems.org/gems/dirfy/versions/$NEW_VERSION"