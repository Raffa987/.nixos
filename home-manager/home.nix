{
  config,
  username,
  pkgs,
  inputs,
  ...
}:

let
  link = config.lib.file.mkOutOfStoreSymlink;
  # Usiamo il percorso assoluto pulito per sicurezza con mkOutOfStoreSymlink
  dotfilesPath = "/home/${username}/.nixos/dotfiles"; 
in {
  imports = [
    ./ags.nix
    ./fish.nix
    ./git.nix
  ];
  
  # Questo è il blocco SICURO per collegare i file
  xdg.configFile = {
    "ags".source = link "${dotfilesPath}/ags";
    "fastfetch".source = link "${dotfilesPath}/fastfetch";
    "hypr".source = link "${dotfilesPath}/hypr";
    "kitty".source = link "${dotfilesPath}/kitty";
  };

  home.stateVersion = "25.05";
}