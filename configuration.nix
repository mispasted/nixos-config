# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./wayland/wayland.nix
      ./nixos-virtualmachine-ssh.nix
      ./grub-bootloader/grub-booloader.nix
    ];

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    neovim
    kitty
    git
    ranger
  ];

  # "experimental?" yet "Necessary."
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  boot.blacklistedKernelModules = [ "wl" ];
  boot.kernelModules = [ "b43" ];
  hardware.firmware = [
    pkgs.b43Firmware_6_30_163_46
  ];

  networking.hostName = "scapula"; # Define your hostname.
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable network manager applet
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."mispasted" = {
    isNormalUser = true;
    description = "mispasted";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      git
      gh
      tldr
    ];
  };

  programs.zsh.enable = true;
  
  # All users in the wheel group are allowed to access the nix daemon:
  nix.settings.allowed-users = [ "@wheel" ]; 

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [  ];
  # networking.firewall.allowedUDPPorts = [  ];

  system.stateVersion = "26.05"; #DON'T CHANGE -MP
}

