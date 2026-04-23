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
      if ${pkgs.git}/bin/git clone --depth=1 https://github.com/iDvel/rime-ice "$TMP_DIR/rime-ice" \
        && cp -R "$TMP_DIR/rime-ice"/. "$RIME_DIR"/; then
        :
      else
        echo "home-manager: warning: rime-ice bootstrap failed (network?). Fix and run darwin-rebuild again." >&2
      fi
    fi
  '';

  # 必须在 linkGeneration 之后：activate 里 set -e，若上面 git clone 失败会整段退出，原来写 squirrel 的 install 永远执行不到。
  # 单独挂在 linkGeneration 后，保证每次激活都会落盘，且晚于 HM 清理/建链。
  home.activation.syncRimeSquirrelCustom = lib.hm.dag.entryAfter ["linkGeneration"] ''
    RIME_DIR="$HOME/Library/Rime"
    ${pkgs.coreutils}/bin/mkdir -p "$RIME_DIR"
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
