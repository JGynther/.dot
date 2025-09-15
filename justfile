default:
    @just --list

switch:
    nh darwin switch

update:
    nix flake update nixpkgs --flake ./nix/

fmt:
    alejandra --quiet nix/
