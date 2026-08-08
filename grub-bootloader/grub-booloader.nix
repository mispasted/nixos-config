# grub-bootloader.nix
{config, pkgs, lib, ...}:
{
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
   /*  efiSupport = true;
    device = "nodev" */

    useOSProber = true;

    # Dotfile repo for theme: https://github.com/Patato777/dotfiles/tree/main
    # Grub theme tutorial: https://web.archive.org/web/20200216035806/http://wiki.rosalab.ru/en/index.php/Grub2_theme_tutorial
    # More grub themes: https://github.com/vinceliuice/grub2-themes
    # theme = ./virtuaverse-theme;

    # gfxmodeEfi = "1920x1080";
    # gfxpayloadEFi = "keep";

    timeoutStyle = "menu";
  };

  boot.loader.timeout = 5;
}
