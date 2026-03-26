{
  username,
  hostname,
  ...
}: {
  nix.enable = false;
  system.primaryUser = username;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [ username ];
    auto-optimise-store = true;
  };

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

  system.activationScripts.postActivation.text = ''
    /usr/sbin/scutil --set ComputerName "${hostname}"
    /usr/sbin/scutil --set HostName "${hostname}"
    /usr/sbin/scutil --set LocalHostName "${hostname}"
  '';

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
