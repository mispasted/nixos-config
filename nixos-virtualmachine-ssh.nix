{config, pkgs, lib, ...}:
{
  # Enable the OpenSSH daemon.
  services.openssh = {
    	enable = true;

	  settings = {
	  	PasswordAuthentication = false;
	  	KbdInteractiveAuthentication = false;
	  	PermitRootLogin = "yes";
	  };
  };

  users.users.mispasted.openssh.authorizedKeys.keys = [
  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII11P3CVGh6o2ow+eASXUbFJoXk4eAtWvSESRfkZ3Etn nixos"
  ];

  programs.nix-ld.enable = true;

  security.sudo = {
    enable = true;

    extraRules = [
      {
        users = [ "mispasted" ];
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}