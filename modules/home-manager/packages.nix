{pkgs, ...}: {
  home.packages = with pkgs; [
    jq
    lazygit
  ] ++ [
    (pkgs.writeShellScriptBin "mkdevshell" (builtins.readFile ../../scripts/mkdevshell))
    (pkgs.writeShellScriptBin "rebuild" (builtins.readFile ../../scripts/rebuild))
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
