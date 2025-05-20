{
  config,
  inputs,
  pkgs,
  ...
}:

let
  link = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file = {
    ".config/fastfetch".source = link "/etc/nixos/home-manager/fastfetch";
    ".config/kitty".source = link "/etc/nixos/home-manager/kitty";
  }; 
  
}
