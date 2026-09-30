# services/sway/default.nix
{
  lib,
  config,
  options,
  pkgs,
  ...
}:
let
  name = "sway"; # program name
  type = "services"; # organizational catagory
  cfg = config.mispasted.${type}.${name};
in
{
  # --- option definitions ---
  options.mispasted.${type}.${name} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable's ${name}.";
    };
  };

  # --- configuration definitions ---
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wl-clipboard # Copy/Paste functionality.
      mako # Notification utility.
      swayfx
      kanshi
    ];

    # Enables Gnome Keyring to store secrets for applications.
    services.gnome.gnome-keyring.enable = true;

    # Enable Sway
    # It's intended that the user will configure sway
    # As well as additional applications.
    # However, this package itself is recommended for
    # A system level install.
    programs.sway = {
      enable = true;
      package = pkgs.swayfx;
      wrapperFeatures.gtk = true;

      # This allow sway to find executables installed by home-manager
      extraSessionCommands = ''
        export PATH="$HOME/.nix-profile/bin:$PATH"
      '';
    };

    # kanshi systemd service
    # Enables monitor hot swapping
    systemd.user.services.kanshi = {
      description = "kanshi daemon";
      environment = {
        WAYLAND_DISPLAY = "wayland-1";
        DISPLAY = ":0";
      };
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.kanshi}/bin/kanshi -c kanshi_config_file";
      };
    };
  };
}
