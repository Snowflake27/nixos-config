{ pkgs, lib, ... }:

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

			# Edit starship to include a non-merged PR
			(pkgs.starship.overrideAttrs (oldAttrs: {
				# Make sure to apply patches if starship defined any
				patches = (oldAttrs.patches or []) ++ [
					(pkgs.fetchpatch {
						# blank-fill PR 7111
					    url = "https://github.com/starship/starship/pull/7111.patch";

						# You give it the correct SHA so nixos knows it's safe and not altered
						sha256 = "sha256-NtPZT9Qu+gtnsGMToHfqUWnKq3N1/WSaO//kSAvj6rw=";
					})
				];

				# Should fix starship build failing because of missing repo
				postPatch = (oldAttrs.postPatch or "") + ''
					if [ -f build.rs ]; then
						sed -i 's/expect("Failed to process filename")/unwrap_or("")/g' build.rs
					fi
				'';
		    }))
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

		starship = {
			enable = true;

			presets = [];

			settings = builtins.fromTOML (builtins.readFile ./configs/starship.toml);
		};

		pay-respects = {
			enable = true;
			aiIntegration = false;
		};
	};

	environment.shellAliases = ezaAliases;
}