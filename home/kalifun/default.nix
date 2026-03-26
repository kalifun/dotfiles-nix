{
  pkgs,
  username,
  ...
}: {
  imports = [
    ../../modules/home-manager
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "25.05";

    sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "iTerm.app";
    };

    # Symlink config files
    file.".zshrc".source = ../../config/zsh/.zshrc;

    # Rime custom config (雾凇拼音用 git clone 直接装)
    file."Library/Rime/squirrel.custom.yaml".source = ../../config/rime/squirrel.custom.yaml;
  };

  xdg.configFile = {
    "starship.toml".source = ../../config/starship.toml;
    "nvim".source = ../../config/nvim;
    "karabiner".source = ../../config/karabiner;
    "tmux".source = ../../config/tmux;
    "ghostty".source = ../../config/ghostty;
  };

  programs.home-manager.enable = true;
}
