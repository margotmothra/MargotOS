{
  description = "MargotOS";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nvf.url = "github:notashelf/nvf";
    stylix.url = "github:danth/stylix/release-25.05";
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";
    niri.url = "github:sodiboo/niri-flake";
    xremap-flake.url = "github:xremap/nix-flake";

    # System monitoring tool (standalone)
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Zen browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nix-flatpak,
    niri,
    xremap-flake,
    dgop,
    zen-browser,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    host = "dget";
    profile = "amd";
    username = "margot";

    # Deduplicate nixosConfigurations while preserving the top-level 'profile'
    mkNixosConfig = gpuProfile:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit host;
          inherit profile; # keep using the let-bound profile for modules/scripts
        };
        modules = [
          ./profiles/${gpuProfile}
          nix-flatpak.nixosModules.nix-flatpak
          niri.nixosModules.niri
          xremap-flake.nixosModules.default
        ];
      };
  in {
    nixosConfigurations = {
      amd = mkNixosConfig "amd";
      nvidia = mkNixosConfig "nvidia";
      nvidia-laptop = mkNixosConfig "nvidia-laptop";
      amd-hybrid = mkNixosConfig "amd-hybrid";
      intel = mkNixosConfig "intel";
      vm = mkNixosConfig "vm";
    };
  };
}
