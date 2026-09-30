{
  description = "Mispasted's NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    waveforms = {
      url = "path:./privileged-programs/waveforms/waveforms-local-package";
    };
  };

  outputs = inputs@{ 
    self, 
    nixpkgs, 
    waveforms, 
    ...
     }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.scapula = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
        };

        modules = [
          ./configuration.nix
          ./hosts/scapula
        ];
      };
    };
}
