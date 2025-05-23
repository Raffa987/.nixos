{
  username,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./symlinks.nix
    ./fish.nix
    ./gtk.nix
    ./git.nix
    #./ags.nix
    ./hyprpaper.nix
  ];

  home = {
    stateVersion = "24.11";
  };
}
