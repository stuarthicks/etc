{ config, pkgs, ... }: {
  home.stateVersion = "20.09";
  programs.home-manager.enable = true;

  home.username = "stuart";
  home.homeDirectory = "/home/stuart";

  home.language.base = "en_GB.UTF-8";
  home.sessionVariables.LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";

  programs.direnv.enable = true;
  programs.direnv.enableNixDirenvIntegration = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    _1password
    _1password-gui
    bzip2
    cargo
    gcc
    gdbm
    git-lfs
    gitAndTools.gh
    gitAndTools.tig
    glibc
    glibcLocales
    gnupg
    go
    golangci-lint
    grepcidr
    jdk
    jq
    kubectl
    lazygit
    libffi
    libxml2
    libyaml
    ncurses
    nodejs
    openssl
    pipenv
    python2Full
    readline
    ripgrep
    ruby_2_7
    shellcheck
    sslyze
    starship
    stow
    tmux
    unixtools.xxd
    vim
    zlib
  ];
}
