# scapula/default.nix
{
  config,
  pkgs,
  lib,
  ...
}:
{
  mispasted.bringup = {
    grub.enable = true;
    greetd.enable = true;
  };

  mispasted.services = {
    sway.enable = true;
  };

  mispasted.programs = {
    waveforms.enable = true;
    xremap.enable = true;
  };

  imports = [
    ./ssh.nix # SSH config
    ./hardware-configuration.nix # Hardware configuration from NixOS installation.
  ];

  # "experimental?" yet "Necessary."
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Fix the missing wifi driver issue
  boot.blacklistedKernelModules = [ "wl" ];
  boot.kernelModules = [ "b43" ];
  hardware.firmware = [
    pkgs.b43Firmware_6_30_163_46
  ];

  networking.hostName = "scapula"; # Define your hostname.


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
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05"; # DON'T CHANGE -MP

}
