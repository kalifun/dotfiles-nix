{pkgs, inputs, ...}: {
  home.packages = with pkgs; [
    jq
    lazygit
    inputs.devshells.packages.${pkgs.system}.mkdevshell
  ] ++ [
    (pkgs.writeShellScriptBin "rebuild" (builtins.readFile ../../scripts/rebuild))
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
