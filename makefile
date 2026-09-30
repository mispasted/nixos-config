HOSTNAME := $(shell hostname)

activate:
	nix flake check . --show-trace
	
install:
	nix flake check . && sudo nixos-rebuild build --flake .#$(HOSTNAME) && sudo nixos-rebuild switch --flake .#$(HOSTNAME)

verbose: 
	@echo "HOSTNAME is $(HOSTNAME)"
	@echo "Current directory is $(CURDIR)"
	@echo "Makefile is located at $(MAKEFILE_LIST)"
	nix flake check . --show-trace