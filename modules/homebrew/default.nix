{...}: {
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    taps = [
      "homebrew/cask"
      "homebrew/core"
    ];

    brews = [
      "mole"
    ];

    casks = [
      # Communication
      "wechat"
      "dingtalk"
      "telegram"
      "qq"

      # Input
      "squirrel-app"

      # Browser
      "arc"
      "google-chrome"

      # IDE
      "zed"
      "visual-studio-code"

      # Note
      "obsidian"
      "logseq"

      # Terminal
      "ghostty"
      "iterm2"

      # Player
      "iina"

      # Productivity
      "raycast"
      "karabiner-elements"
      "easydict"
      "orbstack"
      "monitorcontrol"
      "clash-party"

      # Others
      "snipaste"
      "flux-app"
      "beekeeper-studio"
      "mos"
      "mqttx"

      # Fonts
      "font-fira-code"
      "font-monaspace"
    ];

    masApps = {
    };
  };
}
