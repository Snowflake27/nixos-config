{ pkgs, ... }:

{
	# Enable X11 and KDE Plasma
	services.xserver.enable = true;
	services.displayManager.sddm.enable = true;
	services.desktopManager.plasma6.enable = true;

	# Plasma Keyboard Layout
	services.xserver.xkb = {
		layout = "it";
		variant = "";
	};

	environment.systemPackages = with pkgs; [
		kdePackages.kate
	];

	# Nice to have software
	programs.firefox.enable = true;
}