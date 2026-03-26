{
  username,
  system,
  ...
}: {
  imports = [
    ../../modules/darwin
    ../../modules/homebrew
  ];

  networking.hostName = "darwin-arm64-main";

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  nixpkgs.hostPlatform = system;

  system.stateVersion = 6;
}
