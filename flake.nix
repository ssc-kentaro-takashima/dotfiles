{
  description = "Neovim environment with Flakes + Home Manager (gitless install target)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f:
        builtins.listToAttrs (map (system: {
          name = system;
          value = f system;
        }) systems);
      defaultRepo = "ssc-kentaro-takashima/dotfiles";
    in {
      homeConfigurations = {
        wsl = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          modules = [ ./home/home.nix ];
        };
      };

      apps = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          installer = pkgs.writeShellApplication {
            name = "install-dotfiles";
            text = ''
              set -euo pipefail
              export NIX_CONFIG="experimental-features = nix-command flakes"
              nix --extra-experimental-features "nix-command flakes" \
                run github:nix-community/home-manager -- \
                switch -b hm-backup --impure --flake "github:${defaultRepo}#wsl"
            '';
          };
        in {
          install = {
            type = "app";
            program = "${installer}/bin/install-dotfiles";
          };
        });

      formatter = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in pkgs.nixpkgs-fmt);
    };
}