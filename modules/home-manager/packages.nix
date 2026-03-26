{pkgs, ...}: {
  home.packages = with pkgs; [
    jq
    lazygit
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
