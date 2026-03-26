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

    # Rime custom config (雾凇拼音用 git clone 直接装)
    file."Library/Rime/squirrel.custom.yaml".source = ../../config/rime/squirrel.custom.yaml;
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

    if [ ! -e "$RIME_DIR/default.yaml" ]; then
      TMP_DIR="$(mktemp -d)"
      trap 'rm -rf "$TMP_DIR"' EXIT

      echo "Installing rime-ice into $RIME_DIR"
      ${pkgs.git}/bin/git clone --depth=1 https://github.com/iDvel/rime-ice "$TMP_DIR/rime-ice"
      cp -R "$TMP_DIR/rime-ice"/. "$RIME_DIR"/
    fi
  '';

  home.activation.installRustStable = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if ! ${pkgs.rustup}/bin/rustup toolchain list | grep -q '^stable'; then
      echo "Installing default Rust stable toolchain"
      ${pkgs.rustup}/bin/rustup default stable
    fi
  '';

  programs.home-manager.enable = true;
}
