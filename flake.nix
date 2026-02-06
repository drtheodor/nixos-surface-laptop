{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:NikSneMC/catppuccin-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };
  outputs = { self, nixpkgs, catppuccin, home-manager, nix-cachyos-kernel, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
            {
              nixpkgs.overlays = [
                nix-cachyos-kernel.overlays.pinned
              ];
            }
          ./configuration.nix
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.backupFileExtension = "backup";

            home-manager.users.theo = {
              imports = [
                ./home
                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ];
      };
    };
  };
}
