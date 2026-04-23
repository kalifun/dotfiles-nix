{
  lib,
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

  xdg.configFile = {
    "starship.toml".source = ../../config/starship.toml;
    "nvim".source = ../../config/nvim;
    "karabiner".source = ../../config/karabiner;
    "tmux".source = ../../config/tmux;
    "ghostty".source = ../../config/ghostty;
  };

  home.activation.installRimeIce = lib.hm.dag.entryAfter ["writeBoundary"] ''
    RIME_DIR="$HOME/Library/Rime"
    ${pkgs.coreutils}/bin/mkdir -p "$RIME_DIR"

    if [ ! -e "$RIME_DIR/default.yaml" ]; then
      TMP_DIR="$(mktemp -d)"
      trap 'rm -rf "$TMP_DIR"' EXIT

      echo "Installing rime-ice into $RIME_DIR"
      ${pkgs.git}/bin/git clone --depth=1 https://github.com/iDvel/rime-ice "$TMP_DIR/rime-ice"
      cp -R "$TMP_DIR/rime-ice"/. "$RIME_DIR"/
    fi

    # 放在雾凇安装之后，避免与 home.file 激活顺序竞态导致 ~/Library/Rime 里没有该文件
    ${pkgs.coreutils}/bin/install -Dm644 ${../../config/rime/squirrel.custom.yaml} "$RIME_DIR/squirrel.custom.yaml"
  '';

  home.activation.installRustStable = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if ! ${pkgs.rustup}/bin/rustup toolchain list | grep -q '^stable'; then
      echo "Installing default Rust stable toolchain"
      ${pkgs.rustup}/bin/rustup default stable
    fi
  '';

  programs.home-manager.enable = true;
}
