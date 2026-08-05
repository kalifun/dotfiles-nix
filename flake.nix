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

    devshells.url = "github:kalifun/devshells";

    # nub 的第三方 tap，交给 nix-homebrew 声明式管理（否则 brew tap 会因 Taps 根目录归 root 而失败）
    # 用 git+https 而非 github: 前缀，避免解析默认分支时触发 GitHub REST API 限流
    nubjs-tap = {
      url = "git+https://github.com/nubjs/homebrew-tap";
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
    nubjs-tap,
    devshells,
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
              autoMigrate = true;
              enableRosetta = false;
              user = username;
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "nubjs/homebrew-tap" = nubjs-tap;
              };
              mutableTaps = true;
            };
          }

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # 已有 ~/.config/nvim 等目录时，否则 checkLinkTargets 失败会中止整段 HM 激活（Rime 等也不会跑）
            home-manager.backupFileExtension = "hm-backup";
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
