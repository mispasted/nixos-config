{
  description = "Digilent Waveforms";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "i686-linux"
        "x86_64-linux"
        "armv7l-linux"
        "aarch64-linux"
      ];
      names = [
        "adept2-runtime"
        "waveforms"
      ];

      toFlakePackage = system: name: {
        inherit name;
        value =
          (import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [ self.overlay ];
          })."${name}";
      };

      inherit (builtins) map listToAttrs;

      eachSystem =
        f:
        listToAttrs (
          map (system: {
            name = system;
            value = f system;
          }) systems
        );

      packages = eachSystem (
        system:
        let
          all = listToAttrs (map (toFlakePackage system) names);
        in
        all // { default = all.waveforms; }
      );

      overlay =
        final: prev:
        listToAttrs (
          map (name: {
            inherit name;
            value = final.callPackage (./pkgs + "/${name}") { };
          }) names
        );

      apps = eachSystem (system: rec {
        waveforms = {
          type = "app";
          program = "${packages.${system}.waveforms}/bin/waveforms";
        };
        default = waveforms;
      });

      defaultPackage = eachSystem (system: packages.${system}.default);

      defaultApp = eachSystem (system: apps.${system}.default);

      # --- This section of the flake defines the module.
      nixosModule =
        {
          config,
          lib,
          pkgs,
          ...
        }:
        let
          cfg = config.mispasted.programs.waveforms;
        in
        {
          options.mispasted.programs.waveforms.enable = lib.mkEnableOption "Digilent WaveForms";

          config = lib.mkIf cfg.enable {
            nixpkgs.overlays = [ self.overlay ];
            services.udev.packages = [ pkgs.adept2-runtime ];
            environment.systemPackages = [ pkgs.waveforms ];
          };
        };

      devShells = eachSystem (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            packages = [
              (pkgs.python3.withPackages (py: [
                py.python-lsp-server
                py.requests
                py.beautifulsoup4
                py.black
              ]))
            ];
          };
        }
      );

    in
    {
      inherit
        packages
        overlay
        defaultPackage
        apps
        defaultApp
        nixosModule
        ;

      overlays.default = overlay;

      nixosModules.default = nixosModule;

      devShells = devShells;
    };
}
