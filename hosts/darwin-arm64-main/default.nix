{
  username,
  system,
  ...
}: {
  imports = [
    ../../modules/darwin
    ../../modules/homebrew
  ];

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  nixpkgs.hostPlatform = system;

  system.stateVersion = 6;
}
