{ pkgs, lib, ... }:

let
	ezaAliases = import ./aliases/eza.nix { };
in
{
	# Account definition
	users.users."snowflake" = {
		isNormalUser = true;
		description = "Snowflake";
		extraGroups = [ "networkmanager" "wheel" "ssh_users" ];

		packages = with pkgs; [
			kdePackages.kate
			eza
		];

		shell = pkgs.zsh;

		openssh.authorizedKeys.keyFiles = [
			./keys/ssh/vm_ssh_pub_access_key
		];
	};

	programs = {
		zsh = {
			ohMyZsh = {
				enable = true;
				plugins = [
					"colored-man-pages"
					"git"
					"git-prompt"
					"sudo"
				];
			};
		};

		starship = {
			enable = true;

			presets = [
				"nerd-font-symbols"
			];
		};

		pay-respects = {
			enable = true;
			aiIntegration = false;
		};
	};

	environment.shellAliases = ezaAliases;
}