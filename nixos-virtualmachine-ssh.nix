{config, pkgs, lib, ...}:
{
  # Spice integration (vm)
  services.spice-vdagentd.enable = true;
  
  # Enable the OpenSSH daemon.
  services.openssh = {
    	enable = true;

	  settings = {
	  	PasswordAuthentication=true;
	  	KbdInteractiveAuthentication = false;
	  	PermitRootLogin = "yes";
	  };
  };

   users.users.mispasted.openssh.authorizedKeys.keys = [
   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL244qKqU4LedeCWCnL+FcnZqdI0GhrCoaZ7cr3F9Rjy scapula"
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
