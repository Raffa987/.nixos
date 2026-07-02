# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./battery.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "it";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "it2";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.raffaele = {
    isNormalUser = true;
    description = "raffaele";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

programs.hyprland = {
	enable = true;
	xwayland.enable = true;
};

  # Enable automatic login for the user.
  services.getty.autologinUser = "raffaele";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	hyprland
	hyprpaper
  hyprpicker
	vscode
	firefox
	kitty
	discord
	fastfetch
  fish
  brightnessctl
  unzip
  kdePackages.dolphin
  gcc
  libgcc
  gtk4
  typescript
  nodejs_24
  playerctl
  adwaita-icon-theme
  hyprshot
  hypridle
  hyprlock
  openrgb
  grim
  slurp
  wl-clipboard
  man-pages
  man-pages-posix
  steam
  cudaPackages.cuda_nvml_dev
  vim
];

boot.kernelPackages = pkgs.linuxPackages_latest;

services.hardware.openrgb.enable = true;
services.hardware.openrgb.motherboard = "amd";
systemd.oomd.enable = false;
services.earlyoom.enable = true;

programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};
#Attivare dopo aver implementato un sistema di notifiche
#services.earlyoom.enableNotifications = true;


services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';


### clean system
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };


  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    # Fondamentale per far funzionare Wayland/Hyprland
    modesetting.enable = true;

    # Usa i driver closed-source standard per massima stabilità
    open = false;

    # Permetti a nvidia-settings di funzionare
    nvidiaSettings = true;

    # Scegli il pacchetto driver (production è solitamente il più stabile)
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  


  # List services that you want to enable:

  services.gvfs.enable = true;
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

fonts = {
    enableDefaultPackages = true;
    packages =
      with pkgs;
      [
        inputs.apple-fonts.packages.${pkgs.system}.sf-pro
        noto-fonts
        noto-fonts-cjk-sans
        source-han-sans
        source-han-serif
        texlivePackages.fontawesome
        udev-gothic-nf
        adwaita-icon-theme
        kora-icon-theme
      ]
      ++ (with pkgs.nerd-fonts; [
        _0xproto
        droid-sans-mono
      ]);
    fontconfig = {
      defaultFonts =
        let
          fontlist = [
            "DejaVu Sans"
            "Book"
            "Noto Sans CJK JP"
            "Noto Sans Mono CJK JP"
          ];
        in
        {
          serif = [
            "DejaVu Serif"
            "Noto Sans CJK JP"
          ];
          sansSerif = [
            "DejaVu Sans"
            "Noto Sans CJK JP"
          ];
          monospace = [
            "DejaVu Sans Mono"
            "Noto Sans Mono CJK JP"
          ];
        };
    };
  };

}
