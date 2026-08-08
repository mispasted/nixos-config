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
}
