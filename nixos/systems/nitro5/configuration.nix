{
  inputs,
  config,
  pkgs,
  pkgs-stable,
  ...
} @ args: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  boot.loader = {
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

  # Enable networking
  networking.hostName = "NitroNix";
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

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.libinput.enable = true;

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
    extraSpecialArgs = {
      inherit inputs;
      hyprExtra = args.hyprExtra;
    };
    users = {
      elac = import ../../users/elac/home.nix;
    };
  };

  security.wrappers = {
    dlv = {
      owner = "root";
      group = "wheel";
      capabilities = "cap_sys_ptrace+ep";
      source = "${pkgs.delve}/bin/dlv";
    };
    go = {
      owner = "root";
      group = "wheel";
      capabilities = "cap_sys_ptrace+ep";
      source = "${pkgs.go}/bin/go";
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

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  # Key management
  programs.gnupg.agent = {
    enable = true;
    # enableSSHSupport = true;
  };

  programs.zsh.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      glib
      gtk2
      gtk3
      icu
      libgcc
      libGL
      libGLU
      openal
      stdenv.cc.cc.lib
      xorg.libX11
      xorg.libXi
      xorg.libXrandr
      xorg.libXtst
      xorg.libXxf86vm
      zlib
    ];
  };

  # Enables screen-sharing on wayland.
  xdg.portal.wlr.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Key remapping service.
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings.main = {
          "capslock" = "overload(control, esc)";
          # Maps Canadian "guillemets" key to control.
          "102nd" = "rightcontrol";
        };
      };
    };
  };

  services.gvfs.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
  programs.virt-manager.enable = true;

  services.usbmuxd.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Just don't delete or change this unless you need to
  system.stateVersion = "23.11";
}
