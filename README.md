# nix-nvim

Flakes + Home Manager で Neovim 環境を再現するリポジトリです。  
配布先マシンでは git を使わず、公開 GitHub の Flake を直接参照して適用できます。

公開リポジトリ: https://github.com/ssc-kentaro-takashima/dotfiles

## 最短3行インストール（コピペ用）

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon --yes
```
```bash
export NIX_CONFIG="experimental-features = nix-command flakes"
```
```bash
nix --extra-experimental-features "nix-command flakes" run github:nix-community/home-manager -- switch -b hm-backup --impure --flake github:ssc-kentaro-takashima/dotfiles#wsl
```

この3行だけで、gitなしで同じNeovim環境を適用できます。

## ゴール

- 新規マシンで数行のコマンドだけで同一環境を構築
- 管理用マシンのみで更新と push
- 配布先マシンは git 不要

## インストール対象

- neovim
- ripgrep
- fd
- unzip
- lazygit
- luarocks
- sqlite
- sqlite.dev
- pkg-config
- gcc

## 構成

- flake.nix: Flake と Home Manager エントリ
- home/home.nix: ユーザー環境定義
- nvim/: Neovim 設定本体
- scripts/install-from-github.sh: git なしで公開 GitHub から適用
- docs/workflow-next-machine.md: 別マシン用の最短手順
- docs/build-notes.md: 設計メモ

## ローカル検証

1) Nix を導入

sh <(curl -L https://nixos.org/nix/install) --daemon --yes

2) Home Manager で適用

```bash
export NIX_CONFIG="experimental-features = nix-command flakes"
nix --extra-experimental-features "nix-command flakes" run github:nix-community/home-manager -- switch -b hm-backup --impure --flake .#wsl
```

## 別マシン向けコピペ最短手順

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon --yes
export NIX_CONFIG="experimental-features = nix-command flakes"
nix --extra-experimental-features "nix-command flakes" run github:nix-community/home-manager -- switch -b hm-backup --impure --flake github:ssc-kentaro-takashima/dotfiles#wsl
```

上記の 3 行で、git なしで同じ環境を適用できます。

## 公開 GitHub 参照の補助スクリプト

```bash
curl -fsSL https://raw.githubusercontent.com/ssc-kentaro-takashima/dotfiles/main/scripts/install-from-github.sh | bash
```

別リポジトリ/プロファイルを指定する場合:

```bash
curl -fsSL https://raw.githubusercontent.com/ssc-kentaro-takashima/dotfiles/main/scripts/install-from-github.sh | bash -s -- other-owner/other-repo server
```

## Flake App での適用

```bash
export NIX_CONFIG="experimental-features = nix-command flakes"
nix --extra-experimental-features "nix-command flakes" run github:ssc-kentaro-takashima/dotfiles#install
```

## 備考

- USER/HOME は --impure で実行時に取得します。
- apt の libsqlite3-dev は Nix では sqlite.dev を利用します。
- win32yank は任意要件のため含めていません。

## 旧構成からの移行トラブル対応

過去に `nix profile install ...#nvim-env` を使っている場合、Home Manager 適用時に競合することがあります。

nix profile remove nvim-env

その後に switch を再実行してください。
