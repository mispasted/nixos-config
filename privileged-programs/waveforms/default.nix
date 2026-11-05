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
  inputs, 
  ...
}:
{
  imports = [
    # The flake exposes the proper conditionals. 
    inputs.waveforms.nixosModules.default
  ];
}

