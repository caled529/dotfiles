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
      sway = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs system pkgs-stable;
        };

        modules = [
          ./configuration.nix
          ./swayfx.nix
        ];
      };
      gaming = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs system pkgs-stable;
        };

        modules = [
          ./configuration.nix
          ./nvidia-proprietary.nix
        ];
      };
    };
  };
}
