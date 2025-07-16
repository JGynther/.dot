default:
    @just --list

switch:
    nh darwin switch

update:
    nix flake update

fmt:
    alejandra --quiet nix/
