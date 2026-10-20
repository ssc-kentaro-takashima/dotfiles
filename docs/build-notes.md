# Build Notes

- Date: 2026-10-20
- Strategy: Flakes + Home Manager + public GitHub source
- Target: new WSL/server in a few lines
- Distribution model: target machine does not require git

## Design choices

- Neovim config is stored under nvim/ in this repository.
- Home Manager links nvim/ to ~/.config/nvim declaratively.
- USER and HOME are read at runtime via --impure for cross-machine reuse.

## Package mapping

- apt: libsqlite3-dev -> nix: sqlite.dev
- apt-like build tools -> nix: pkg-config + gcc

## Optional items

- win32yank is intentionally excluded (optional in requirements).

