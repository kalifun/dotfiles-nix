{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bat
    eza
    fd
    git
    neovim
    ripgrep
    tmux
    tree
    wget
    zoxide

    # Languages
    go
    rustup
    rust-analyzer
    python3
    nodejs

    # Dev tools
    gh
    uv
    yq
    gitmux
    starship
    sesh
    tree-sitter

    # Zsh
    oh-my-zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];
}
