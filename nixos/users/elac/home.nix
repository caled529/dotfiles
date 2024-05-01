{
  config,
  pkgs,
  ...
}: {
  home.username = "elac";
  home.homeDirectory = "/home/elac";

  # Just don't delete or change this unless you need to
  home.stateVersion = "23.11";

  # Home-manager needs this even if it's already set in configuration.nix
  nixpkgs.config.allowUnfree = true;

  # This would be a good place to modularize and organize packages by usage
  home.packages = with pkgs; [
    alejandra
    anki
    bat
    blueman
    btop
    calcurse
    cargo
    delve
    discord
    eza
    fastfetch
    fd
    firefox
    fzf
    gcc
    gdb
    gh
    gimp
    go
    grim
    jdk21
    jq
    keepassxc
    libreoffice-fresh
    lua
    neovim
    nodejs_21
    playerctl
    python3
    q4wine
    ripgrep
    slurp
    spotify-player
    tree-sitter
    unzip
    wezterm
    wineWowPackages.waylandFull
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.xfconf
    xournalpp
    yazi
    zathura
    zig
    zip
    zoxide
  ];

  # Dotfile symlinking
  home.file = {
    calcurse = {
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink "/home/elac/dotfiles/calcurse";
      target = ".config/calcurse";
    };
    kanshi = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/elac/dotfiles/swayfx/kanshi";
      target = ".config/kanshi/config";
    };
    nvim = {
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink "/home/elac/dotfiles/nvim";
      target = ".config/nvim";
    };
    spotify-player = {
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink "/home/elac/dotfiles/spotify-player";
      target = ".config/spotify-player";
    };
    swayfx = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/elac/dotfiles/swayfx/config";
      target = ".config/sway/config";
    };
    waybar = {
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink "/home/elac/dotfiles/waybar";
      target = ".config/waybar";
    };
    wezterm = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/elac/dotfiles/wezterm.lua";
      target = ".wezterm.lua";
    };
  };

  # Gnome theming stuff
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  gtk.enable = true;

  gtk.gtk2.extraConfig = ''
    gtk-enable-animations = 1
    gtk-primary-button-warps-slider = 0
    gtk-toolbar-style = 3
    gtk-menu-images = 1
    gtk-button-images = 1
    gtk-cursor-theme-size = 24
    gtk-cursor-theme-name = "breeze_cursors"
    gtk-icon-theme-name = "breeze-dark"
    gtk-font-name = "Noto Sans,  10"
  '';

  gtk.gtk3.extraConfig = {
    gtk-application-prefer-dark-theme = true;
    gtk-button-images = true;
    gtk-cursor-theme-name = "breeze_cursors";
    gtk-cursor-theme-size = 24;
    gtk-decoration-layout = "icon:minimize,maximize,close";
    gtk-enable-animations = true;
    gtk-font-name = "Noto Sans,  10";
    gtk-icon-theme-name = "breeze-dark";
    gtk-menu-images = true;
    gtk-primary-button-warps-slider = false;
    gtk-toolbar-style = 3;
    gtk-xft-dpi = 98304;
  };

  gtk.gtk4.extraConfig = {
    gtk-application-prefer-dark-theme = true;
    gtk-cursor-theme-name = "breeze_cursors";
    gtk-cursor-theme-size = 24;
    gtk-decoration-layout = "icon:minimize,maximize,close";
    gtk-enable-animations = true;
    gtk-font-name = "Noto Sans,  10";
    gtk-icon-theme-name = "breeze-dark";
    gtk-primary-button-warps-slider = false;
    gtk-xft-dpi = 98304;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Better cat
  programs.bat.enable = true;

  # Better ls
  programs.eza = {
    enable = true;
    git = true;
    icons = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # GitHub CLI for authentication
  programs.gh.enable = true;

  programs.git = {
    enable = true;
    userEmail = "118690771+caled529@users.noreply.github.com";
    userName = "caled529";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.home-manager.enable = true;

  programs.swaylock = {
    enable = true;
    settings = {
      color = "1b1b1b";
      bs-hl-color = "fad6ea";
      indicator-idle-visible = true;
      inside-color = "fae6fa40";
      inside-clear-color = "fae6fa40";
      inside-ver-color = "fae6fa40";
      inside-wrong-color = "fae6fa40";
      key-hl-color = "fae6fa40";
      line-color = "00000000";
      line-clear-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";
      ring-color = "fae6fa80";
      ring-clear-color = "fae6fa80";
      ring-ver-color = "fae6fa80";
      ring-wrong-color = "fae6fa80";
      separator-color = "00000000";
      text-color = "fae6fa";
      text-clear-color = "fae6fa";
      text-ver-color = "fae6fa";
      text-wrong-color = "fae6fa";
    };
  };

  # Better cd
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = ["--cmd cd"];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;
    history.ignoreAllDups = true;
    initExtra = ''
      setopt prompt_subst
      autoload -U colors && colors
      parse_git_branch() {
          branch=$(git symbolic-ref --short HEAD 2> /dev/null)
          if [ ''${#branch} -gt 0 ]
          then
              echo " $branch "
          fi
      }
      PROMPT='%{%F{014}%}┌[%{%F{012}%}%n@%m %{%F{005}%}%d%{%F{014%}%}]
      └► %{%F{013}%}%1~ %{%F{011}%}$(parse_git_branch)%{%F{007}%}$ %{%F{}%}'
      RPROMPT='%{%F{007}%}[%*]'

      bindkey '^[[Z' autosuggest-accept

      autoload -Uz compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    '';
    shellAliases = {
      ls = "eza --grid -la";
      cat = "bat";
      neofetch = "fastfetch";
      vi = "nvim";
      vim = "nvim";
    };
    syntaxHighlighting.enable = true;
  };
}
