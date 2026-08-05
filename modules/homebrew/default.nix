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
      # Homebrew 6.x 对非官方 tap 强制 Tap-Trust
      {
        name = "nubjs/tap";
        trusted = true;
      }
    ];

    brews = [
      "mole"
      "docker"
      "nub"
    ];

    casks = [
      # Communication
      "telegram"

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
      # "iina"

      # Productivity
      # "raycast"  # Currently using the v2 beta version
      "karabiner-elements"
      "easydict"
      "orbstack"
      "monitorcontrol"
      # "clash-party"

      # Others
      "snipaste"
      "flux-app"
      #"beekeeper-studio"
      "mos"
      "mqttx"

      # Fonts
      "font-fira-code"
      "font-monaspace"

      # AI Tools
      "codex"
      "claude-code"

      # screen recorder
      "bettercapture"
    ];

    masApps = {
    };
  };
}
