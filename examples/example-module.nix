# examples/example-module.nix
{
  lib,
  config,
  options,
  pkgs,
  ...
}:
let
  name = "example"; # program name
  type = "example type"; # organizational catagory
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

    example-enum = lib.mkOption {
      type = lib.types.enum [
        "virtuaverse"
        "default"
      ];
      default = "default";
      description = "Set the example enum value.";
    };
  };

  # --- configuration definitions ---
  config = lib.mkIf cfg.enable {
    # config here ...
    example-enum-virtuaverse-option =
      lib.mkIf cfg.example-enum == "virtuaverse" {
      };
  };
}
