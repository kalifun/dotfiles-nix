{
  description = "macOS Nix setup with nix-darwin, home-manager, and Homebrew";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    homebrew-core = {
      url = "github:Homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:Homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    darwin,
    home-manager,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    ...
  }: let
    mkHost = {
      username,
      hostname,
      system,
    }:
      darwin.lib.darwinSystem {
        inherit system;
        specialArgs = {
          inherit inputs self username hostname system;
        };
        modules = [
          ./hosts/${hostname}

          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = system == "aarch64-darwin";
              user = username;
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
              };
              mutableTaps = false;
            };
          }

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs self username hostname system;
            };
            home-manager.users.${username} = import ./home/${username};
          }
        ];
      };
  in {
    darwinConfigurations.darwin-arm64-main = mkHost {
      username = "kalifun";
      hostname = "darwin-arm64-main";
      system = "aarch64-darwin";
    };

    darwinConfigurations.darwin-x86_64-legacy = mkHost {
      username = "kalifun";
      hostname = "darwin-x86_64-legacy";
      system = "x86_64-darwin";
    };
  };
}
