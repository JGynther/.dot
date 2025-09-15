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
  # /usr/bin/defaults write ~/Library/Preferences/com.apple.security.authorization.plist ignoreArd -bool TRUE
  security.pam.services.sudo_local.touchIdAuth = true;

  homebrew = {
    enable = true;
    user = username;
    onActivation.cleanup = "uninstall";
    taps = [];
    brews = ["icann-rdap"];
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
      "epic-games"
    ];
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
