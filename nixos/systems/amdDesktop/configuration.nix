# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  config,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    # Driver patch for this computer's motherboard - currently no flake support for this patch
    "${builtins.fetchGit {
      url = "https://github.com/NixOS/nixos-hardware.git";
      rev = "ae5c8dcc4d0182d07d75df2dc97112de822cb9d6";
    }}/gigabyte/b550"
  ];

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
    };
  };

  # Enable networking
  networking.hostName = "nixebeest";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable GDM on Wayland
  services.xserver.displayManager.gdm = {
    enable = true;
    autoSuspend = true;
    wayland = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Add users
  users.users.elac = {
    isNormalUser = true;
    description = "elac";
    extraGroups = ["networkmanager" "wheel" "libvirtd"];
    shell = pkgs.zsh;
  };

  # Home-manager setup
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      elac = import ../../users/elac/home.nix;
    };
  };

  # Allow proprietary packages
  nixpkgs.config.allowUnfree = true;

  # System-level packages
  environment.systemPackages = with pkgs-stable; [
    curl
    git
    pkgs.home-manager
    keyd
    vim
    wget
    wl-clipboard
  ];

  # Extra fonts
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    font-awesome
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];

  # Default environment variables
  environment.sessionVariables = {
    EDITOR = "vim";
    GSETTINGS_BACKEND = "keyfile";
  };

  # Enables OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.bluetooth.enable = true;

  # Key management
  programs.gnupg.agent = {
    enable = true;
    # enableSSHSupport = true;
  };

  programs.kdeconnect.enable = true;

  programs.zsh.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      glib
      gtk2
      gtk3
      gtk4
      icu
      libgcc
      libGL
      libGLU
      libxkbcommon
      openal
      rocmPackages.rocm-smi
      stdenv.cc.cc.lib
      xorg.libX11
      xorg.libXi
      xorg.libXrandr
      xorg.libXtst
      xorg.libXxf86vm
      zlib
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    openFirewall = true;
    ports = [39901];
  };

  services.fail2ban.enable = true;

  # Key remapping service.
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings.main = {
          "capslock" = "overload(control, esc)";
          # Maps guillemets key to control. This only really applies to my
          # laptop and maybe other canadian market laptops.
          "102nd" = "rightcontrol";
        };
      };
    };
  };

  services.gvfs.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # OpenRGB
  services.udev = {
    enable = true;
    packages = with pkgs; [
      openrgb
    ];
  };
  hardware.i2c.enable = true;
  boot.kernelModules = ["i2c-dev" "i2c-piix4"];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Just don't delete or change this unless you need to
  system.stateVersion = "23.11";
}
