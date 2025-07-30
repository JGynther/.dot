{username, ...}: {
  nix.enable = false; # Determinate Nix specific
  nix.settings.experimental-features = "nix-command flakes";

  environment.variables = {
    NH_FLAKE = "/etc/nix-darwin";
  };

  users.users.${username} = {
    home = "/Users/${username}";
  };

  # https://discussions.apple.com/thread/255187302?sortBy=rank
  security.pam.services.sudo_local.touchIdAuth = true;

  homebrew = {
    enable = true;
    user = username;
    onActivation.cleanup = "uninstall";
    taps = [];
    brews = [];
    casks = [
      "discord"
      "firefox"
      "google-chrome"
      "secretive"
      "proton-mail-bridge"
      "moonlight"
      "ghostty"
      "tailscale-app"
      "zed"
    ];
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
