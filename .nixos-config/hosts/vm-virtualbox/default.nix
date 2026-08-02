{ pkgs, ... }:

{
	# Sort out Virtual Box Hardware
	imports = [
		./hardware-configuration.nix
	];

	# Set up networking
	networking = {
		hostName = "nixos-vm";
		networkmanager.enable = true;
	};

	# Bootloader
	boot.loader = {
		systemd-boot.enable = true;
		efi.canTouchEfiVariables = true;
	};

	# VirtualBox Settings
	virtualisation.virtualbox.guest.enable = true;

	fileSystems."/shared" = {
		fsType = "vboxsf";
		device = "shared";
		options = [ "rw" "uid=1000" "gid=100" "nofail" ];
	};

	# Set up an env variable with the configuration name
	environment.sessionVariables = {
		NIX_CURRENT_FLAKE_CONFIG = "vm-virtualbox";
	};
}