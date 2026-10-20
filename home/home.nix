{ config, pkgs, ... }:
let
  username =
    let u = builtins.getEnv "USER";
    in if u != "" then u else "dev";
  homeDir =
    let h = builtins.getEnv "HOME";
    in if h != "" then h else "/home/${username}";
in {
  home.username = username;
  home.homeDirectory = homeDir;
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    unzip
    lazygit
    luarocks
    sqlite
    sqlite.dev
    pkg-config
    gcc
  ];

  home.file = {
    ".config/nvim" = {
      source = ../nvim;
      recursive = true;
    };
  };
}
