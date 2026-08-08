{config, pkgs, lib, ...}:
{
   imports = [
    ./sddm/sddm.nix # Display Manager
    ./sway.nix # Window Manager
   ]; 
}