{...}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    shortcut = "a";
    terminal = "screen-256color";
    extraConfig = ''
      set -g base-index 1
      setw -g pane-base-index 1
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "tmux config reloaded"
    '';
  };

  xdg.configFile."tmux/tmux.conf".text = ''
    set -g history-limit 100000
    set -g renumber-windows on
  '';
}
