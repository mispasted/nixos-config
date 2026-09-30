# sddm/default.nix
{
  lib,
  config,
  options,
  pkgs,
  ...
}:
let
  name = "sddm"; # program name
  type = "bringup"; # organizational catagory
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

    theme = lib.mkOption {
      type = lib.types.enum [
        "superhot"
        "default"
      ];
      default = "default";
      description = "Set the theme for sddm";
    };
  };

  # --- configuration definitions ---
  config = lib.mkIf cfg.enable (
    let
      SuperHotTheme = pkgs.callPackage ./Derive-SuperHotTheme.nix { };
    in
    {
      environment.systemPackages = lib.mkIf (cfg.theme == "superhot") (
        with pkgs;
        [
          # These are all needed for the Theme.
          # Since these programs need to be available on the SDDM level.
          SuperHotTheme
          gst_all_1.gst-plugins-good
          gst_all_1.gst-libav
          kdePackages.qtmultimedia
        ]
      );

      services.displayManager.sddm = {
        enable = true;

        # It's either this or enable the xserver... no way would I do that!
        wayland.enable = true;

        # Make these available to sddm service
        extraPackages = lib.mkIf (cfg.theme == "superhot") [
          pkgs.gst_all_1.gst-plugins-good
          pkgs.gst_all_1.gst-libav
          pkgs.kdePackages.qtmultimedia
          SuperHotTheme
        ];
      };

      # This is the name of the FOLDER installed to usr/share/sddm/themes
      # by the derivation
      services.displayManager.sddm.theme = lib.mkIf (cfg.theme == "superhot") "SuperHotTheme";
    }
  );
}
