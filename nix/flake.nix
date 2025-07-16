{
  description = "Macos Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
    }@inputs:
    let
      username = "gynther";
      hostname = "MacBook-Air";
      system = "aarch64-darwin";
      specialArgs = { inherit inputs username hostname; };

      configuration =
        { pkgs, ... }:
        {
          nix.enable = false; # Determinate Nix specific
          nix.settings.experimental-features = "nix-command flakes";

          environment.variables = {
            NH_FLAKE = "/etc/nix-darwin";
          };

          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = system;

          users.users.${username} = {
            home = "/Users/${username}";
          };

          # https://discussions.apple.com/thread/255187302?sortBy=rank
          security.pam.services.sudo_local.touchIdAuth = true;

          environment.systemPackages = with pkgs; [
            nixd
            nixfmt-rfc-style
            just
            nh
          ];
        };
    in
    {
      darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
        inherit system specialArgs;
        modules = [ configuration ];
      };
    };
}
