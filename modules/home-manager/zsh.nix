{config, pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    # Oh My Zsh
    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
    };

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # User config loaded from ~/.zshrc
    initExtra = "source ~/.zshrc";
  };
}
