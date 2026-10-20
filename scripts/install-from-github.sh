#!/usr/bin/env bash
set -euo pipefail

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
  echo "Usage: $0 <github_owner/repo> [flake_profile]"
  echo "Example: $0 your-account/nix-nvim wsl"
  exit 0
fi

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
  echo "Usage: $0 <github_owner/repo> [flake_profile]" >&2
  exit 1
fi

repo="$1"
profile="${2:-wsl}"

export NIX_CONFIG="experimental-features = nix-command flakes"

nix --extra-experimental-features "nix-command flakes" \
  run github:nix-community/home-manager -- \
  switch -b hm-backup --impure --flake "github:${repo}#${profile}"
