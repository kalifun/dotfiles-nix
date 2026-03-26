{
  username,
  system,
  ...
}: {
  imports = [
    ../../modules/darwin
    ../../modules/homebrew
  ];

  networking.hostName = "darwin-x86_64-legacy";

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  nixpkgs.hostPlatform = system;

  system.stateVersion = 6;
}
