{
  username,
  hostname,
  ...
}: {
  # Set to true when Nix is installed by the official installer, false when using Determinate Nix.
  # Determinate 管理 /etc/nix/nix.conf；自定义项写到 nix.custom.conf（见下方 environment.etc）。
  nix.enable = false;
  system.primaryUser = username;

  # Determinate Nix：国内 binary cache 优先（priority 越小越优先；官方源默认 40）
  # https://mirror.sjtu.edu.cn/docs/nix-channels/store
  # https://mirrors.ustc.edu.cn/help/nix-channels.html
  environment.etc."nix/nix.custom.conf".text = ''
    extra-substituters = https://mirror.sjtu.edu.cn/nix-channels/store?priority=10 https://mirrors.ustc.edu.cn/nix-channels/store?priority=20
    trusted-users = ${username}
    auto-optimise-store = true
  '';

  nixpkgs.config.allowUnfree = true;

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    LANG = "en_US.UTF-8";
    HOMEBREW_API_DOMAIN = "https://mirrors.ustc.edu.cn/homebrew-bottles/api";
    HOMEBREW_BOTTLE_DOMAIN = "https://mirrors.ustc.edu.cn/homebrew-bottles";
  };

  programs.zsh.enable = true;

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
    };
  };
}
