{...}: {
  programs.git = {
    enable = true;
    userName = "kalifun";
    userEmail = "you@example.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
