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
      fzf
    ] ++ (with inputs.ags.packages.${pkgs.system}; [
      battery
      network
    ]);
  };
}
