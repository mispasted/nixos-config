# greetd/default.nix
{
  lib,
  config,
  options,
  pkgs,
  ...
}:
let
  name = "greetd"; # program name
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
  };

  # --- configuration definitions ---
  config = lib.mkIf cfg.enable {
    programs.regreet.enable = true;
  };
}
