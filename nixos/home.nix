{
  config,
  pkgs,
  ...
}: {
  home.username = "elac";
  home.homeDirectory = "/home/elac";

  # Just don't delete or change this unless you need to
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    alejandra
    bat
    blueman
    btop
    cargo
    eza
    firefox
    fuzzel
    fzf
    gcc
    gh
    grim
    keepassxc
    kitty
    lua
    neofetch
    neovim
    nodejs_21
    playerctl
    slurp
    spotify-player
    unzip
    xournalpp
    zig
    zip
    zoxide
  ];

  # Dotfile symlinking
  home.file = {
    nvim = {
      recursive = true;
      # https://discourse.nixos.org/t/how-to-manage-dotfiles-with-home-manager/30576/3
      source = config.lib.file.mkOutOfStoreSymlink "/home/elac/dotfiles/nvim";
      target = ".config/nvim";
    };
    # With enough effort the config could be rewritten in nix but I'd rather not
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

  # Works better than the regular home-manager session variables
  systemd.user.sessionVariables = {
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
    settings = {
      disable_ligatures = "never";
      copy_on_select = "yes";
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      active_tab_background = "#bbb";
      inactive_tab_foreground = "#222";
      inactive_tab_background = "#777";
      background_opacity = "0.9";
      text_fg_override_threshold = 2;
    };
    shellIntegration.enableZshIntegration = true;
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
    };
    syntaxHighlighting.enable = true;
  };
}
