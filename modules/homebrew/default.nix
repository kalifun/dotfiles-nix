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
      "farion1231/ccswitch"
    ];

    brews = [
      "clash-party"
      "mole"
    ];

    casks = [
      # Communication
      "wechat"
      "dingding"
      "telegram"
      "qq"

      # Input
      "squirrel"

      # Browser
      "arc-browser"
      "google-chrome"

      # AI
      "cc-switch"

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

      # Others
      "snipaste"
      "f.lux"
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
