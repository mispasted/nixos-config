# waveforms/default.nix
# Waveforms serves as the interface for the "Analog Discovery 2" device.
# It requires access to the USB device, therefore must be run with appropriate privileges.
# The module requires the co-located package/flake to be added to flake.nix. Example:
# 
# flake.nix snippet:
# waveforms = {
#   url = "path:./privileged-programs/waveforms/waveforms-local-package";
# };
{
  lib,
  config,
  options,
  pkgs,
  inputs,
  ...
}:
let
  name = "waveforms"; # program name
  type = "programs"; # organizational catagory
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

    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "mispasted" ];
      description = "List of users who should have access to the plugdev group for waveforms.";
    };
  };

  # --- conditional imports ---
  imports = lib.mkIf cfg.enable [
    inputs.waveforms.nixosModules.default
  ];

  # --- configuration definitions ---
  config = lib.mkIf cfg.enable {
    # Create the plugdev group, and add the specified users to it.
    users.groups.plugdev.members = lib.unique cfg.users;
  };
}
