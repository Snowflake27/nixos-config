{
    description = "Snowflake's NixOS Configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        # Nix community database, for `nix-index`
        nix-index-database.url = "github:nix-community/nix-index-database";
        nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, nix-index-database, ... }@inputs:
    let
        configPath = "/etc/nixos/flake-config";

        coreModules = [
            ./modules/core.nix
            nix-index-database.nixosModules.nix-index
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

                    # Add desktop environment
                    ./modules/desktop/plasma/plasma.nix

                    # Add all servers
                    ./modules/servers/ssh.nix

                    # Add all needed software
					./modules/apps/development/python-uv.nix
					./modules/apps/development/node-fnm.nix

                    # Set up my admin user
                    ./modules/users/snowflake/snowflake.nix
                ];
            };
        };
    };
}