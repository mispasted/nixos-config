{config, pkgs, lib, ...}:
{
  environment.systemPackages = with pkgs; 
  [
      wl-clipboard # Copy/Paste functionality.
      mako # Notification utility.
      swayfx
  ];

  # Enables Gnome Keyring to store secrets for applications. 
  services.gnome.gnome-keyring.enable = true;

  # Enable Sway
/*   programs.sway = 
  {
    enable = true;
    # package = pkgs.sway;
    wrapperFeatures.gtk = true;
    # xwayland.enable = true;

    # Nice list: https://github.com/swaywm/sway/wiki/Useful-add-ons-for-sway
    # Currently the default
    # extraPackages = with pkgs;
    #   [
    #     brightnessctl 
    #     foot
    #     grim
    #     pulseaudio
    #     swayidle
    #     swaylock
    #     wmenu
    #   ];
  };
  # programs.waybar.enable = true */

  wayland.windowManager.sway = {
  enable = true;
  package = pkgs.swayfx;
  
  # Needed to build without errors.
  checkConfig = false;
    
  # SwayFX options must be configured through extraConfig.
  extraConfig = ''
    shadows enable
    corner_radius 11
    blur_radius 7
    blur_passes 2
  '';
};


}