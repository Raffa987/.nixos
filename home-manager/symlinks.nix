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

  services.hyprpaper = {
    enable = true;

    settings = {

      splash = false;
      splash_offset = 2.0;
      preload = [
        "/home/raffaele/.nixos/home-manager/wallpaper/Sailor-Moon-wallpaper-for-desktop.jpg"
      ];

      wallpaper = [
        "eDP-1, /home/raffaele/.nixos/home-manager/wallpaper/Sailor-Moon-wallpaper-for-desktop.jpg"
      ];
    };
  };
}
