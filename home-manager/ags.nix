 {
  inputs,
  pkgs,
  ...
}:

{
  imports = [ inputs.ags.homeManagerModules.default ];
  programs.ags = {
    enable = true;
    extraPackages = with pkgs; [
      astal.hyprland
      astal.battery
      fzf
      ] ++ (with inputs.ags.packages.${pkgs.system}; [
        astal4
        network
        wireplumber
        mpris
    ]);
  };
} 