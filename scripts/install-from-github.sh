#!/usr/bin/env bash
set -euo pipefail

default_repo="ssc-kentaro-takashima/dotfiles"
default_profile="wsl"

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
  echo "Usage: $0 [github_owner/repo] [flake_profile]"
  echo "Default: $0 ${default_repo} ${default_profile}"
  echo "Example: $0 other-owner/other-repo server"
  exit 0
fi

if [ $# -gt 2 ]; then
  echo "Usage: $0 [github_owner/repo] [flake_profile]" >&2
  exit 1
fi

repo="${1:-$default_repo}"
profile="${2:-$default_profile}"

export NIX_CONFIG="experimental-features = nix-command flakes"

nix --extra-experimental-features "nix-command flakes" \
  run github:nix-community/home-manager -- \
  switch -b hm-backup --impure --flake "github:${repo}#${profile}"
