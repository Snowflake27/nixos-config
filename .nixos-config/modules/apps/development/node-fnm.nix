{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		fnm
	];

	programs.nix-ld = {
        enable = true;
    };
}