{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "eza -lah";
      vim = "nvim";
      cat = "bat";
    };
    initContent = ''
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
    '';
  };
}
