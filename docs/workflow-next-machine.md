# Workflow: 別マシンへ最短導入

配布先マシンに git は不要です。

## 1) Nix を導入

sh <(curl -L https://nixos.org/nix/install) --daemon --yes

シェルを再起動するか再ログイン。

## 2) 公開GitHubのFlakeをそのまま適用

export NIX_CONFIG="experimental-features = nix-command flakes"
nix --extra-experimental-features "nix-command flakes" run github:nix-community/home-manager -- switch -b hm-backup --impure --flake github:<your-account>/<your-repo>#wsl

## 3) 動作確認

nvim --version
rg --version
fd --version
lazygit --version
sqlite3 --version

## 4) 更新適用

同じコマンドを再実行するだけで更新が反映されます。

## トラブルシュート

旧構成から移行するマシンで `nvim-env` 競合エラーが出る場合:

nix profile remove nvim-env

その後、適用コマンドを再実行してください。

