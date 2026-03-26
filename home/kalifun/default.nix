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
  };

  programs.home-manager.enable = true;
}
