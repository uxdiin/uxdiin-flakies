{
 description = "uxdiin's flakies";

 inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hardware
    hardware.url = "github:nixos/nixos-hardware";

    hyprland.url = "github:hyprwm/Hyprland";
        
 };

 outputs = { self, nixpkgs, home-manager, hyprland, nixpkgs-stable,... } @inputs:
   let
     system = "x86_64-linux";
      overlay-stable = final: prev: {
        # unstable = nixpkgs-unstable.legacyPackages.${prev.system};
        # use this variant if unfree packages are needed:
        stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };

      };
   in  {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname
      uxdiin = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; }; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [ 
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-stable ]; })
          ./nixos/configuration.nix
           hyprland.nixosModules.default
             {
                 programs.hyprland.enable = true;
                 programs.hyprland.nvidiaPatches = true;
             }
        ];
      };
    };

    # home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # FIXME replace with your username@hostname
      "uxdiin@uxdiin" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs;}; # Pass flake inputs to our config
        # > Our main home-manager configuration file <
        modules = [ 
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-stable ]; })
            ./home-manager/home.nix 
            ];
      };
    };
   }; 
}
