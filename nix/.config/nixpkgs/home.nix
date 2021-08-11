{ config, pkgs, ... }: {

  home.language.base = "en_GB.UTF-8";

  programs.home-manager.enable = true;
  services.lorri.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    _1password
    cargo
    cmake
    dogdns
    fd
    gh
    git-lfs
    glibc
    glibcLocales
    go
    grepcidr
    jq
    ncat
    ncdu
    openssl
    powershell
    pv
    ripgrep
    screen
    shellcheck
    starship
    stow
    tig
    tmux
    vim
    xxd
    zlib
  ];

}
