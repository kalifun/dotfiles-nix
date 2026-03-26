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
    ];

    casks = [
      "google-chrome"
      "iterm2"
      "visual-studio-code"
    ];

    masApps = {
    };
  };
}
