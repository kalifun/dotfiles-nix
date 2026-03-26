{...}: {
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = false;
      user = {
        name = "kalifun";
        email = "kalifun@163.com";
      };
    };
  };
}
