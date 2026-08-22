{config, pkgs, lib, ...}:
{
   imports = [
    ./greetd/greetd.nix # Display Manager
    ./sway.nix # Window Manager
   ]; 
}