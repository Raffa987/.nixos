{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      inputs.ags.packages.${pkgs.system}.battery
      fzf
    ];
  };
}
