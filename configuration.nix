{ config, pkgs, inputs, ... }:
{

  # These imports only define options, rather than installing anything.
  # The flake file should also import the appropriate host configuration,
  # Which sets the options such that the system is configured according to the host-specific settings.
  imports =
    [ 
      ./bringup
      ./services
      ./privileged-programs
    ];

  # Packages I think every system should have.
  # Mainly for setting up the nixos-config and home-manager repos
  # Try to keep this very short, since systems can't opt out of these.   
  environment.systemPackages = with pkgs; [
    neovim
    kitty
    git
    ranger
    gnumake
    home-manager
  ];
}

