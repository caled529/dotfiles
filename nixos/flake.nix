{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      # Home Desktop
      nixebeest = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs system pkgs-stable;
        };
        modules = [
          ./systems/amdDesktop/configuration.nix
          ./desktops/hyprland.nix
          ./gaming/steam.nix
          ./gaming/mihoyo.nix
        ];
      };

      # Laptop
      sway = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs system pkgs-stable;
        };
        modules = [
          ./systems/nitro5/configuration.nix
          ./hardware-changes/v4l2.nix
          ./desktops/swayfx.nix
        ];
      };
      gaming = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs system pkgs-stable;
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
        modules = [
          ./desktops/gnome.nix
          ./gaming/mihoyo.nix
          ./gaming/misc.nix
          ./gaming/steam.nix
          ./hardware-changes/nvidia-proprietary-drivers.nix
          ./hardware-changes/v4l2.nix
          ./systems/nitro5/configuration.nix
        ];
      };
    };
  };
}
