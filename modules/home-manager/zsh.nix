{...}: {
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

    # Load user shell customizations after Home Manager's generated setup.
    initContent = builtins.readFile ../../config/zsh/.zshrc;
  };
}
