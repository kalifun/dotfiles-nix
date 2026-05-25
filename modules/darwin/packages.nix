{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bat
    eza
    fd
    git
    subversion
    neovim
    ripgrep
    tmux
    tree
    wget
    zoxide

    # Languages
    #go
    #rustup
    #rust-analyzer
    #python3
    #nodejs
    bun

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
