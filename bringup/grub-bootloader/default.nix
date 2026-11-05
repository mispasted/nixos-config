# grub-bootloader/default.nix
{
  lib,
  config,
  options,
  pkgs,
  ...
}:
let
  name = "grub"; # program name
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
        "virtuaverse"
        "default"
      ];
      default = "default";
      description = "Set the theme for GRUB.";
    };

  };
  # --- configuration definitions ---
  config = lib.mkIf cfg.enable {
    boot.loader.efi.canTouchEfiVariables = true;

    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      timeoutStyle = "menu";
    };

    boot.loader.timeout = 5;

    # Dotfile repo for theme: https://github.com/Patato777/dotfiles/tree/main
    # Grub theme tutorial: https://web.archive.org/web/20200216035806/http://wiki.rosalab.ru/en/index.php/Grub2_theme_tutorial
    # More grub themes: https://github.com/vinceliuice/grub2-themes
    # theme = ./virtuaverse-theme;
    # Themes - must also be allowed in the option enum
    boot.loader.grub.theme = if cfg.theme == "virtuaverse" then ./virtuaverse-theme else null;

  };
}

