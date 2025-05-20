{
  username,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./symlinks.nix
  ];

  home = {
    stateVersion = "24.11";
  };
}
