{ pkgs, ... }:

{
	# Account definition
	users.users."snowflake" = {
		isNormalUser = true;
		description = "Snowflake";
		extraGroups = [ "networkmanager" "wheel" "ssh_users" ];

		packages = with pkgs; [
			kdePackages.kate
		];

		openssh.authorizedKeys.keyFiles = [
			./keys/ssh/vm_ssh_pub_access_key
		];
	};
}