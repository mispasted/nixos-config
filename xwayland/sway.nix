{config, pkgs, lib, ...}:
{
  environment.systemPackages = with pkgs; 
  [
      wl-clipboard # Copy/Paste functionality.
      mako # Notification utility.
      swayfx
      kanshi
  ];

  # Enables Gnome Keyring to store secrets for applications. 
  services.gnome.gnome-keyring.enable = true;

  # Enable Sway
   programs.sway = 
  {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;

    # Nice list: https://github.com/swaywm/sway/wiki/Useful-add-ons-for-sway
    # Currently the default
  };

  # kanshi systemd service
  # Enables monitor hot swapping
systemd.user.services.kanshi = {
  description = "kanshi daemon";
  environment = {
    WAYLAND_DISPLAY="wayland-1";
    DISPLAY = ":0";
  }; 
  serviceConfig = {
    Type = "simple";
    ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
  };
};

}
