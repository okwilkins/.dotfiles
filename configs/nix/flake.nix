{
  description = "My Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
    defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;

    homeConfigurations = {
        "oli" = inputs.home-manager.lib.homeManagerConfiguration {
		system = "x86_64-linux";
                homeDirectory = "/home/oli";
                username = "oli";
                configuration.imports = [ ./home.nix ];
        };                                                                                                                                                                                                                                                      };
  };
}
