{
    description = "Snowflake's NixOS Configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs, ... }@inputs:
    let
        configPath = "/etc/nixos/flake-config";

        coreModules = [
            ./modules/core.nix
        ];
    in {
        nixosConfigurations = {
            # VM Settings
            vm-virtualbox = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";

                specialArgs = {
                    inherit configPath;
                };

                modules = coreModules ++ [
                    # Host setup
                    ./hosts/vm-virtualbox/default.nix

                    # Add plasma
                    ./modules/desktop/plasma/plasma.nix

                    # Add SSH
                    ./modules/servers/ssh.nix

                    # Set up my admin user
                    ./modules/users/snowflake/snowflake.nix
                ];
            };
        };
    };
}