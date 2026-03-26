{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bat
    eza
    fd
    fzf
    git
    neovim
    ripgrep
    tmux
    tree
    wget
    zoxide
  ];
}
