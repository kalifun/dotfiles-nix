{pkgs, ...}: {
  home.packages = with pkgs; [
    jq
    lazygit
  ] ++ [
    (pkgs.writeShellScriptBin "mkdevshell" (builtins.readFile ../../scripts/mkdevshell))
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
