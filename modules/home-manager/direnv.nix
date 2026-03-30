{pkgs, ...}: {
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    package = pkgs.direnv.overrideAttrs (old: {
      env = (old.env or {}) // { CGO_ENABLED = "1"; };
    });
  };
}
