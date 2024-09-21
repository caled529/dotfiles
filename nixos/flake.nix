{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprcursor-phinger.url = "github:jappie3/hyprcursor-phinger";
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
          hyprExtra = ''
            monitor = DP-1, 2560x1440@180Hz, 0x0, 1
            monitor = DP-2, 1920x1080@144Hz, 2560x0, 1, transform, 3
            workspace = 1, monitor:DP-1
            workspace = 2, monitor:DP-1
            workspace = 3, monitor:DP-1
            workspace = 4, monitor:DP-1
            workspace = 5, monitor:DP-1
            workspace = 6, monitor:DP-2
            workspace = 7, monitor:DP-2
            workspace = 8, monitor:DP-2
            workspace = 9, monitor:DP-2
            workspace = 10, monitor:DP-2
          '';
        };
        modules = [
          ./systems/amdDesktop/configuration.nix
          ./desktops/hyprland.nix
          ./gaming/mihoyo.nix
          ./gaming/misc.nix
          ./gaming/retroarch.nix
          ./gaming/steam.nix
          ./hardware-changes/v4l2.nix
        ];
      };

      # Nitro5
      hypr = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs system pkgs-stable;
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
          hyprExtra = ''
            monitor = eDP-1, 1920x1080@144Hz, 1920x0, 1
            monitor = eDP-2, 1920x1080@144Hz, 1920x0, 1
            monitor = HDMI-A-1, 1920x1080@144Hz, 0x0, 1
            monitor = HDMI-A-2, 1920x1080@144Hz, 0x0, 1
          '';
        };
        modules = [
          ./systems/nitro5/configuration.nix
          ./hardware-changes/nvidia-proprietary-drivers.nix
          ./hardware-changes/v4l2.nix
          ./desktops/hyprland.nix
          ./gaming/steam.nix
          ./gaming/mihoyo.nix
        ];
      };
      minimal = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs system pkgs-stable;
        };
        modules = [
          ./systems/minimal/configuration.nix
          ./systems/nitro5/hardware-configuration.nix
        ];
      };
      sway = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs system pkgs-stable;
          hyprMonitors = [];
        };
        modules = [
          ./systems/nitro5/configuration.nix
          ./hardware-changes/v4l2.nix
          ./desktops/swayfx.nix
        ];
      };
    };
  };
}
