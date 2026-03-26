{
  username,
  hostname,
  ...
}: {
  nix.enable = false;

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
  };

  programs.zsh.enable = true;

  security.pam.services.sudo_local.touchIdAuth = true;

  system.activationScripts.postUserActivation.text = ''
    /usr/sbin/scutil --set ComputerName "${hostname}"
    /usr/sbin/scutil --set HostName "${hostname}"
    /usr/sbin/scutil --set LocalHostName "${hostname}"

    # Clone 雾凇拼音
    RIME_DIR="$HOME/Library/Rime"
    if [[ ! -d "$RIME_DIR" ]]; then
      echo "Cloning rime-ice to $RIME_DIR..."
      git clone https://github.com/iDvel/rime-ice "$RIME_DIR"
    fi
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
