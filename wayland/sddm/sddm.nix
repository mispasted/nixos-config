# sddm.nix
{lib, config, pkgs, ...}:
let
    SuperHotTheme = pkgs.callPackage ./Derive-SuperHotTheme.nix { };
in
{
     environment.systemPackages = with pkgs; 
    [
       # These are all needed for the Theme. 
       # Since these programs need to be available on the SDDM level.
       SuperHotTheme
       gst_all_1.gst-plugins-good
       gst_all_1.gst-libav
       kdePackages.qtmultimedia
    ]; 
     
    services.displayManager.sddm = {
        enable = true;

        # It's either this or enable the xserver... no way would I do that!
        wayland.enable = true;

        # This is the name of the FOLDER installed to usr/share/sddm/themes
        # by the derivation.
        theme = "SuperHotTheme"; 

        # Make these available to sddm service
        extraPackages = [
            SuperHotTheme
            pkgs.gst_all_1.gst-plugins-good
            pkgs.gst_all_1.gst-libav
            pkgs.kdePackages.qtmultimedia
        ]; 
    };   
}