{
  config,
  pkgs,
  hyprMonitors,
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
    fuse
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
    kitty
    libreoffice-fresh
    lua
    neovim
    nodePackages_latest.nodejs
    ntfs3g
    openrgb
    playerctl
    python3
    q4wine
    ripgrep
    slurp
    spotify-player
    swaylock
    tree-sitter
    unzip
    waybar
    wineWowPackages.waylandFull
    wofi
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
    hypridle = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/elac/dotfiles/hypr/hypridle.conf";
      target = ".config/hypr/hypridle.conf";
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

  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCodeNerdFont";
      package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
      size = 12;
    };
    keybindings = rec {
      mod = "super";
      # Tabs
      "${mod}+t" = "new_tab_with_cwd";
      "${mod}+shift+t" = "new_tab";
      "${mod}+shift+x" = "close_tab";
      "${mod}+," = "previous_tab";
      "${mod}+." = "next_tab";
      "${mod}+shift+," = "move_tab_backward";
      "${mod}+shift+." = "move_tab_forward";
      "${mod}+1" = "goto_tab 1";
      "${mod}+2" = "goto_tab 2";
      "${mod}+3" = "goto_tab 3";
      "${mod}+4" = "goto_tab 4";
      "${mod}+5" = "goto_tab 5";
      "${mod}+6" = "goto_tab 6";
      "${mod}+7" = "goto_tab 7";
      "${mod}+8" = "goto_tab 8";
      "${mod}+9" = "goto_tab 9";
      "${mod}+0" = "goto_tab 10";
      # Windows (splits)
      "${mod}+s" = "launch --location=hsplit --cwd=current";
      "${mod}+v" = "launch --location=vsplit --cwd=current";
      "${mod}+r" = "layout_action rotate";
      "${mod}+x" = "close_window_with_confirmation ignore-shell";
      "${mod}+d" = "detach_window";
      "${mod}+h" = "neighboring_window left";
      "${mod}+j" = "neighboring_window down";
      "${mod}+k" = "neighboring_window up";
      "${mod}+l" = "neighboring_window right";
      "${mod}+shift+h" = "move_window left";
      "${mod}+shift+j" = "move_window down";
      "${mod}+shift+k" = "move_window up";
      "${mod}+shift+l" = "move_window right";
      "${mod}+shift+r" = "start_resizing_window";
      "${mod}+=" = "reset_window_sizes";
      "${mod}+f" = "toggle_fullscreen";
    };
    settings = {
      disable_ligatures = "never";
      copy_on_select = "yes";
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      active_tab_background = "#bbb";
      inactive_tab_foreground = "#222";
      inactive_tab_background = "#777";
      background_opacity = "0.8";
      text_fg_override_threshold = 2;
      enabled_layouts = "splits";
    };
    shellIntegration.enableZshIntegration = true;
    theme = "Space Gray Eighties"; # Source Code X
  };

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

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with pkgs.hyprlandPlugins; [
      hy3
    ];
    settings = {
      exec-once = [
        "${pkgs.hypridle}/bin/hypridle"
        "waybar"
      ];
      "$mod" = "ALT";
      "$term" = "kitty";

      "general:layout" = "hy3";
      bind = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
        # Locking and sleeping the system
        "$mod CTRL, l, exec, swaylock"
        "$mod CTRL, s, exec, systemctl suspend"
        # Running applications
        "$mod, w, exec, firefox" # browser
        "$mod, p, exec, keepassxc" # password manager
        "$mod, d, exec, wofi -iS drun" # search and run applications
        "$mod SHIFT, d, exec, wofi -iS run" # search and run PATH binaries
        "$mod, ESCAPE, exec, $term --class=floating_util btop" # sys-monitor
        # Screenshots
        "$mod SHIFT, s, exec, grim -g \"$(slurp)\" $HOME/grim_screenshots/$(date +\"%Y-%m-%d_%Hh%Mm%Ss\")_grim.png"
        # Killing windows
        "$mod SHIFT, q, hy3:killactive"
        # Moving window focus
        "$mod, h, hy3:movefocus, l"
        "$mod, j, hy3:movefocus, d"
        "$mod, k, hy3:movefocus, u"
        "$mod, l, hy3:movefocus, r"
        # Moving the windows
        "$mod SHIFT, h, hy3:movewindow, l"
        "$mod SHIFT, j, hy3:movewindow, d"
        "$mod SHIFT, k, hy3:movewindow, u"
        "$mod SHIFT, l, hy3:movewindow, r"
        # Selecting workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        # Send windows to other workspaces
        "$mod SHIFT, 1, movetoworkspacesilent, 1"
        "$mod SHIFT, 2, movetoworkspacesilent, 2"
        "$mod SHIFT, 3, movetoworkspacesilent, 3"
        "$mod SHIFT, 4, movetoworkspacesilent, 4"
        "$mod SHIFT, 5, movetoworkspacesilent, 5"
        "$mod SHIFT, 6, movetoworkspacesilent, 6"
        "$mod SHIFT, 7, movetoworkspacesilent, 7"
        "$mod SHIFT, 8, movetoworkspacesilent, 8"
        "$mod SHIFT, 9, movetoworkspacesilent, 9"
        "$mod SHIFT, 0, movetoworkspacesilent, 10"
        # Toggle floating status of focused window
        "$mod SHIFT, SPACE, togglefloating"
        # Toggle focus between floating and tiled windows
        ''$mod, SPACE, exec, hyprctl dispatch focuswindow $(if [[ $(hyprctl activewindow -j | jq ."floating") == "true" ]]; then echo "tiled"; else echo "floating"; fi;)''
        # Toggle resize mode
        "$mod, r, submap, resize"
        # Toggle always-on-top
        "$mod, t, exec, hyprctl dispatch pin"
      ];
      # Binds that repeat when held
      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
      ];
      # Mouse bindings
      bindm = [
        "$mod,mouse:272,movewindow"
      ];
      # Key-released bindings, needed to bind modifier keys
      bindr = [
        "$mod, RETURN, exec, $term"
      ];
      misc = {
        force_default_wallpaper = 0; # No more anime
        disable_hyprland_logo = 1;
      };
      monitor = hyprMonitors;
      plugin = {
        hy3 = {
          no_gaps_when_only = 1;
          autotile.enable = 1;
        };
      };
      windowrule = [
        "float,^(floating_util)$"
        "move 20% 15%,^(floating_util)$"
        "size 60% 75%,^(floating_util)$"
        "minsize 800 480,^(floating_util)$"
      ];
    };
    # Need to use extraConfig for submap configuration
    extraConfig = ''
      submap = resize
      binde = , h, resizeactive, -10 0
      binde = , j, resizeactive, 0 -10
      binde = , k, resizeactive, 0 10
      binde = , l, resizeactive, 10 0
      bindm = , mouse:272, resizewindow 1
      bindm = SHIFT, mouse:272, resizewindow 2
      bind = , escape, submap, reset
      submap = reset
    '';
  };
}
