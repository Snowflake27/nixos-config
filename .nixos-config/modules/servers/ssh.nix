{ ... }:

{
	# Group to assign to users allowed to use SSH
	users.groups.ssh-users = {};

	# OpenSSH setup
	services.openssh = {
		enable = true;
		ports = [ 2222 ];
		openFirewall = true;
		settings = {
			PasswordAuthentication = false;
			KbdInteractiveAuthentication = false;
			PermitRootLogin = "no";
			AllowGroups = [ "ssh_users" ];
			MaxAuthTries = 3;
			PerSourcePenalties = "crash:3600s authfail:3600s max:864600s";
		};
	};
}