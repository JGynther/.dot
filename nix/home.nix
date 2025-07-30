{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # Nix
    nixd
    nh
    alejandra # nixfmt-rfc-style

    # CLIs
    eza # ls
    bat # cat
    doggo # DNS
    atuin # shell history
    fzf # fuzzy finder
    starship # shell prompt
    fastfetch
    just # command runner

    # Langs
    inputs.fenix.packages.${system}.stable.toolchain # Rust
    gleam
    python3
    uv
    bun

    # Data
    sqlite
    duckdb
  ];

  home.file = {
    ".config/ghostty/config".source = ../ghostty.conf;
  };

  programs.git = {
    enable = true;

    userName = "Joona Gynther";
    userEmail = "joona@gynther.xyz";

    signing.key = "/Users/gynther/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/PublicKeys/9936cc014b4729a0ff90a393bc592c60.pub";
    signing.format = "ssh";
    signing.signByDefault = true;

    maintenance.enable = true;
    delta.enable = true;

    extraConfig.init.defaultBranch = "main";
    ignores = [".DS_Store"];
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;

    sessionVariables = {
      SHELL = "zsh";
      SSH_AUTH_SOCK = "/Users/gynther/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
      PATH = "/Users/gynther/.cargo/bin:$PATH"; #:$HOME/.bun/bin
    };

    shellAliases = {
      ".." = "cd ..";
      z = "zed .";
      n = "zed ~/.dot";
      switch = "just -f ~/.dot/justfile switch";
      cat = "bat";
      ls = "eza -F";
      python = "python3";
      pip = "python -m pip";
      venv = "source .venv/bin/activate";
    };

    initContent = builtins.readFile ../.zshrc;
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "25.05";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
