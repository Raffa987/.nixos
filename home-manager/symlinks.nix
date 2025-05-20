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

  gtk = {
  enable = true;
  
  theme = {
    name = "Adwaita-dark";
    package = pkgs.gnome-themes-extra;
  };

  iconTheme = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
  };

  cursorTheme = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
  };

  gtk3.extraConfig = {
    gtk-application-prefer-dark-theme = 1;
  };

  gtk4.extraConfig = {
    gtk-application-prefer-dark-theme = 1;
  };
};

  programs = {
    git = {
      enable = true;
      userEmail = "raffa.cannizzo@gmail.com";
      userName = "Raffa987";
    };
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
