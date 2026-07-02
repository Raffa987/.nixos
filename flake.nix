{
  description = "home-manager";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
      self,
      nixpkgs,
      home-manager,
      ags,
      ...
  }@inputs:
    let
      username = "raffaele";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      myExtraPackages = [
        # e.g. ags.packages.${system}.battery
        ags.packages.${system}.hyprland
      ];
    in
    {
      packages.${system}.default = ags.lib.bundle {
        inherit pkgs;
        src = ./.;
        name = "my-shell";
        entry = "app.ts";
        gtk4 = true;

        extraPackages = myExtraPackages ++ [pkgs.gtk4];
      };
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit username inputs; };
        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "lol6";
              extraSpecialArgs = { inherit username inputs; };
              users."${username}" = import ./home-manager/home.nix;
            };
          }
        ];
      };
    };
}