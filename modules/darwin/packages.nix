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

    # Languages
    go
    rust
    rust-analyzer
    python3
    nodejs

    # Dev tools
    gh
    yq
    gitmux
    starship
    sesh

    # Zsh
    oh-my-zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];
}
