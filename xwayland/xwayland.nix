{config, pkgs, lib, ...}:
{
   imports = [
    ./sway.nix
    ./sddm/sddm.nix
   ]; 
}