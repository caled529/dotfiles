{
  inputs,
  config,
  pkgs,
  hyprExtra ? "",
  ...
}: {
  imports = [
    inputs.hyprcursor-phinger.homeManagerModules.hyprcursor-phinger
  ];

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
    jetbrains.idea-ultimate
    jq
    keepassxc
    kitty
    libreoffice-fresh
    lua
    myxer
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
    vesktop
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
  };

  # Gnome theming stuff
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  gtk = {
    enable = true;
    gtk2.extraConfig = ''
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
    gtk3.extraConfig = {
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
    gtk4.extraConfig = {
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
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        size = 12;
      };
      shell = "${pkgs.zsh}/bin/zsh";
    };
  };

  programs.bat.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    config = {
      global.hide_env_diff = true;
    };
    nix-direnv.enable = true;
  };

  programs.eza = {
    enable = true;
    git = true;
    icons = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

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

  programs.hyprcursor-phinger.enable = true;

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

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      nix_shell = {
        format = "via [$symbol$name]($style) ";
        symbol = " ";
      };
    };
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 10;
    extraConfig = ''
      set -g status-position top
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      bind s choose-tree -sZ -O name
      new-session -c ~
    '';
    keyMode = "vi";
    mouse = true;
    newSession = true;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_window_current_text "#W"
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_status_modules_right "session user host"
        '';
      }
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
    ];
    prefix = "C-Space";
    terminal = "screen-256color";
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
      bindkey '^[[Z' autosuggest-accept
      autoload -Uz compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    '';
    shellAliases = {
      ls = "eza --grid -la";
      cat = "bat";
      neofetch = "fastfetch";
      nd = "nix develop";
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
      env = let
        hyprcursorTheme = "phinger-cursors-dark-hyprcursor";
        xcursorTheme = "${pkgs.phinger-cursors}/share/icons/phinger-cursors-dark";
      in [
        "HYPRCURSOR_THEME,${hyprcursorTheme}"
        "HYPRCURSOR_SIZE,24"
        "XCURSOR_THEME,${xcursorTheme}"
        "XCURSOR_SIZE,24"
      ];
      exec-once = [
        "${pkgs.hypridle}/bin/hypridle"
        "${pkgs.playerctl}/bin/playerctld"
        "waybar"
      ];
      exec = let
        gtkConfig = "\${XDG_CONFIG_HOME:-$HOME/.config}/gtk-3.0/settings.ini";
        gnomeSchema = "org.gnome.desktop.interface";
        gtkTheme = ''$(grep 'gtk-theme-name' ${gtkConfig} | sed 's/.*\s*=\s*//')'';
        iconTheme = ''$(grep 'gtk-icon-theme-name' ${gtkConfig} | sed 's/.*\s*=\s*//')'';
        cursorTheme = "Phinger Cursors (dark)";
        fontName = ''$(grep 'gtk-font-name' ${gtkConfig} | sed 's/.*\s*=\s*//')'';
      in [
        "${pkgs.glib}/bin/gsettings set ${gnomeSchema} gtk-theme ${gtkTheme}"
        "${pkgs.glib}/bin/gsettings set ${gnomeSchema} icon-theme ${iconTheme}"
        ''${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/cursor-theme "'${cursorTheme}'"''
        "${pkgs.glib}/bin/gsettings set ${gnomeSchema} font-name ${fontName}"
      ];
      "$mod" = "ALT";
      "$term" = "alacritty";

      "general:layout" = "hy3";
      bind = let
        focusLeft = pkgs.writeShellScript "focusLeft.sh" ''
          active_address=$(hyprctl activewindow -j | jq -r .address)
          hyprctl dispatch hy3:movefocus l
          if [[ $active_address = $(hyprctl activewindow -j | jq -r .address) ]]
          then
            focused_monitor_id=$(hyprctl activeworkspace -j | jq -r .monitorID)
            left_active_workspace_id=$(hyprctl monitors -j | jq -r ". | sort_by(.x)[$(echo $(($focused_monitor_id - 1)) | awk '{print($0<0?0:$0)}')] | .activeWorkspace.id")
            active_floating=$(hyprctl activewindow -j | jq -r .floating)
            left_window_x=$(hyprctl clients -j | jq -r "[.[] | select(.workspace.id==$left_active_workspace_id)] | sort_by(.at[0]) | sort_by(.floating==$active_floating)[-1].at[0]")
            left_window_addr=$(hyprctl clients -j | jq -r "[.[] | select(.workspace.id==$left_active_workspace_id) | select(.at[0]==$left_window_x)] | sort_by(.focusHistoryID)[0].address")
            hyprctl dispatch focuswindow address:$left_window_addr
          fi
        '';
        focusRight = pkgs.writeShellScript "focusRight.sh" ''
          active_address=$(hyprctl activewindow -j | jq -r .address)
          hyprctl dispatch hy3:movefocus r
          if [[ $active_address = $(hyprctl activewindow -j | jq -r .address) ]]
          then
            focused_monitor_id=$(hyprctl activeworkspace -j | jq -r .monitorID)
            right_active_workspace_id=$(hyprctl monitors -j | jq -r ". | sort_by(.x)[$(($focused_monitor_id + 1))] | .activeWorkspace.id")
            active_floating=$(hyprctl activewindow -j | jq -r .floating)
            right_window_x=$(hyprctl clients -j | jq -r "[.[] | select(.workspace.id==$right_active_workspace_id)] | sort_by(.at[0]) | reverse | sort_by(.floating==$active_floating)[-1].at[0]")
            right_window_addr=$(hyprctl clients -j | jq -r "[.[] | select(.workspace.id==$right_active_workspace_id) | select(.at[0]==$right_window_x)] | sort_by(.focusHistoryID)[0].address")
            hyprctl dispatch focuswindow address:$right_window_addr
          fi
        '';
        movewindowLeft = pkgs.writeShellScript "movewindowLeft.sh" ''
          active_window_pos_x=$(hyprctl activewindow -j | jq -r ".at[0]")
          hyprctl dispatch hy3:movewindow l
          if [[ $active_window_pos_x = $(hyprctl clients -j | jq -r "[.[] | select(.workspace.id==$(hyprctl activeworkspace -j | jq -r .id)).at[0]] | min") ]]
          then
            focused_monitor_id=$(hyprctl activeworkspace -j | jq -r .monitorID)
            left_active_workspace_id=$(hyprctl monitors -j | jq -r ". | sort_by(.x)[$(echo $(($focused_monitor_id - 1)) | awk '{print($0<0?0:$0)}')] | .activeWorkspace.id")
            hyprctl dispatch movetoworkspace $left_active_workspace_id
          fi
        '';
        movewindowRight = pkgs.writeShellScript "movewindowRight.sh" ''
          active_window_pos_x=$(hyprctl activewindow -j | jq -r ".at[0]")
          hyprctl dispatch hy3:movewindow r
          if [[ $active_window_pos_x = $(hyprctl clients -j | jq -r "[.[] | select(.workspace.id==$(hyprctl activeworkspace -j | jq -r .id)).at[0]] | max") ]]
          then
            focused_monitor_id=$(hyprctl activeworkspace -j | jq -r .monitorID)
            right_active_workspace_id=$(hyprctl monitors -j | jq -r ". | sort_by(.x)[$(($focused_monitor_id + 1))] | .activeWorkspace.id")
            hyprctl dispatch movetoworkspace $right_active_workspace_id
          fi
        '';
        currMonitor = ''$(hyprctl activeworkspace -j | jq .monitorID)'';
        nextMonitor = ''$((${currMonitor} + 1))'';
        prevMonitor = ''$(echo $((${currMonitor} - 1)) | awk '{print($0<0?0:$0)}')'';
        nextMonitorWorkspace = ''$(hyprctl monitors -j | jq ".[] | select(.id==${nextMonitor}).activeWorkspace.id")'';
        prevMonitorWorkspace = ''$(hyprctl monitors -j | jq ".[] | select(.id==${prevMonitor}).activeWorkspace.id")'';
      in [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
        ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
        # Locking and sleeping the system
        "$mod CTRL, l, exec, swaylock"
        "$mod CTRL, s, exec, systemctl suspend"
        # Running applications
        "$mod, w, exec, firefox" # browser
        "$mod, p, exec, keepassxc" # password manager
        "$mod, d, exec, wofi -iS drun" # search and run applications
        "$mod SHIFT, d, exec, wofi -iS run" # search and run PATH binaries
        "$mod, ESCAPE, exec, $term --class=floating_util -e btop" # sys-monitor
        # Screenshots
        "$mod SHIFT, s, exec, grim -g \"$(slurp)\" $HOME/grim_screenshots/$(date +\"%Y-%m-%d_%Hh%Mm%Ss\")_grim.png"
        # Killing windows
        "$mod SHIFT, q, hy3:killactive"
        # Moving window focus
        "$mod, h, exec, ${focusLeft}"
        "$mod, j, hy3:movefocus, d"
        "$mod, k, hy3:movefocus, u"
        "$mod, l, exec, ${focusRight}"
        # Moving the windows
        "$mod SHIFT, h, exec, ${movewindowLeft}"
        "$mod SHIFT, j, hy3:movewindow, d"
        "$mod SHIFT, k, hy3:movewindow, u"
        "$mod SHIFT, l, exec, ${movewindowRight}"
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
        "$mod SHIFT, 1, hy3:movetoworkspace, 1"
        "$mod SHIFT, 2, hy3:movetoworkspace, 2"
        "$mod SHIFT, 3, hy3:movetoworkspace, 3"
        "$mod SHIFT, 4, hy3:movetoworkspace, 4"
        "$mod SHIFT, 5, hy3:movetoworkspace, 5"
        "$mod SHIFT, 6, hy3:movetoworkspace, 6"
        "$mod SHIFT, 7, hy3:movetoworkspace, 7"
        "$mod SHIFT, 8, hy3:movetoworkspace, 8"
        "$mod SHIFT, 9, hy3:movetoworkspace, 9"
        "$mod SHIFT, 0, hy3:movetoworkspace, 10"
        # Toggle floating status of focused window
        "$mod SHIFT, SPACE, togglefloating"
        # Toggle focus between floating and tiled windows
        ''$mod, SPACE, exec, hyprctl dispatch focuswindow $(if [[ $(hyprctl activewindow -j | jq ."floating") == "true" ]]; then echo "tiled"; else echo "floating"; fi;)''
        # Toggle resize mode
        "$mod, r, submap, resize"
        # Toggle always-on-top
        "$mod, t, exec, hyprctl dispatch pin"
        # Toggle fullscreen on focused window
        "$mod, f, fullscreen"
        # Change focus to next/previous monitor
        "$mod, code:60, exec, hyprctl dispatch focusmonitor ${nextMonitor}"
        "$mod, code:59, exec, hyprctl dispatch focusmonitor ${prevMonitor}"
        # Send active window to next/previous monitor
        "$mod SHIFT, code:60, exec, hyprctl dispatch movetoworkspace ${nextMonitorWorkspace}"
        "$mod SHIFT, code:59, exec, hyprctl dispatch movetoworkspace ${prevMonitorWorkspace}"
      ];
      # Binds that repeat when held
      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 2%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
      ];
      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
      ];
      # Key-released bindings, needed to bind modifier keys
      bindr = [
        "$mod, RETURN, exec, $term"
      ];
      cursor = {
        hide_on_key_press = true;
        no_warps = true;
      };
      general = {
        gaps_out = 5;
      };
      misc = {
        force_default_wallpaper = 0; # No more anime
        disable_hyprland_logo = 1;
      };
      plugin = {
        hy3 = {
          no_gaps_when_only = 0;
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
    extraConfig =
      ''
        submap = resize
        binde = , h, resizeactive, -10 0
        binde = , j, resizeactive, 0 -10
        binde = , k, resizeactive, 0 10
        binde = , l, resizeactive, 10 0
        binde = SHIFT, h, resizeactive, -50 0
        binde = SHIFT, j, resizeactive, 0 -50
        binde = SHIFT, k, resizeactive, 0 50
        binde = SHIFT, l, resizeactive, 50 0
        bindm = , mouse:272, resizewindow 1
        bindm = SHIFT, mouse:272, resizewindow 2
        bindm = $mod, mouse:272, movewindow"
        bind = , escape, submap, reset
        submap = reset
      ''
      + hyprExtra;
  };
}
