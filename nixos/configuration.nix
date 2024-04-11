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

  networking.hostName = "NitroNix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
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
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

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
      elac = import ./home.nix;
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
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.bluetooth.enable = true;

  # Key management
  programs.gnupg.agent = {
    enable = true;
    # enableSSHSupport = true;
  };

  programs.zsh.enable = true;

  # Ideally SwayFX and related setup would exist in a home-manager file.
  security.polkit.enable = true;
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
    extraPackages = with pkgs; [swaylock swayidle kitty bemenu waybar wl-clipboard];
    wrapperFeatures.gtk = true;
  };

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

  # Enables screen-sharing
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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Just don't delete or change this unless you need to
  system.stateVersion = "23.11";
}
