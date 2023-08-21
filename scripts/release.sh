#!/bin/sh

##############################
#                            #
#  Copyright (c) xTekC.      #
#  Licensed under MPL-2.0.   #
#  See LICENSE for details.  # 
#                            #
##############################

set -e

if [ -z "$1" ]; then
    echo "Please provide a tag."
    echo "Usage: ./release.sh v[X.Y.Z]"
    exit
fi

GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "Updated release to ${GREEN}$1${NC}"

# update version
sed -E -i "/^\[package\]$/,/^\[/ s/^(version = \").*\"$/\1${1#v}\"/" Cargo.toml
cargo build --profile rel-opt

# update changelog
git cliff --tag "$1" --config config/cliff.toml >CHANGELOG.md
git add -A
git commit -m "chore(release): prepare for $1"
git show

# generate a changelog for the tag message
changelog=$(git cliff --tag "$1" --config config/cliff.toml --unreleased --strip all | sed -e '/^#/d' -e '/^$/d')

# create signed tag
# git tag -s "$1" -m "$changelog"

# create unsigned tag
git tag -a "$1" -m "$changelog"

# verify signed tag
# git tag -v "$1"

echo "Done!"
echo "Push the commit (git push), wait for CI, then push the tag (git push origin v<tag_num>)."

# Creating Release

# [GitHub](https://github.com/xTeKc/unic/releases) and [crates.io](https://crates.io/crates/unic) releases are automated via [GitHub actions](.github/workflows/cd.yml) and triggered by pushing a tag.

# 1. Run the [release script](./scripts/release.sh): `./scripts/release.sh v[X.Y.Z]` (requires [git-cliff](https://github.com/orhun/git-cliff) for changelog generation)
# 2. Push the changes: `git push`
# 3. Check if [Continuous Integration](https://github.com/xTeKc/unic/actions) workflow is completed successfully.
# 4. Push the tags: `git push --tags` or a specific tag `git push origin v<tag_num>`
# 5. Wait for [Continuous Deployment](https://github.com/xTeKc/unic/actions) workflow to finish.
