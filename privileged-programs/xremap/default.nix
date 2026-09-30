# xremap/default.nix
# This module doesn't actually install xremap.
# It simply sets the proper permissions for user-level configuration.
# See: https://github.com/xremap/xremap/blob/master/doc/running_without_sudo.md
{
  lib,
  config,
  options,
  pkgs,
  ...
}:
let
  name = "xremap"; # program name
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

  # --- configuration definitions ---
  config = lib.mkIf cfg.enable {
    # Add users to the input group for xremap access.
    users.groups.input.members = lib.unique cfg.users;

    # Set udev rules
    services.udev.extraRules = ''
      KERNEL=="uinput", GROUP="input", TAG+="uaccess", MODE:="0660", OPTIONS+="static_node=uinput"
    '';
  };
}
