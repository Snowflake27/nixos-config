{ pkgs, lib, configPath, ... }:

let
	ezaAliases = import ./aliases/eza.nix { };

	# Add all scripts to the init dynamically
	scriptsDir = ./scripts/shell-init;
	folderContents = builtins.attrNames (builtins.readDir scriptsDir);

	allFiles = map (fileName: scriptsDir + "/${fileName}") folderContents;
	combinedShellInit = builtins.concatStringsSep "\n" (map builtins.readFile allFiles);
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
			oh-my-posh
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

			interactiveShellInit = combinedShellInit;
		};

		pay-respects = {
			enable = true;
			aiIntegration = false;
		};

		git = {
			enable = true;
		};
	};

	environment.shellAliases = ezaAliases;
}