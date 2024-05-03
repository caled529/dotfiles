{...}: let
  aagl-gtk-on-nix = import (builtins.fetchTarball {
    url = "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz";
    sha256 = "0v0w4clflp4i4k423724gk38lak9rj3g4yl4kpi8j6aqjs3sxi3y";
  });
in {
  nix.settings = {
    substituters = ["https://ezkea.cachix.org"];
    trusted-public-keys = ["ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="];
  };

  imports = [
    aagl-gtk-on-nix.module
  ];

  programs.anime-game-launcher.enable = true; # Genshin Impact
  programs.anime-games-launcher.enable = false; # General Launcher
  programs.anime-borb-launcher.enable = false; # Punishing: Gray Raven (Not Mihoyo)
  programs.honkers-railway-launcher.enable = false; # Honkai Star Rail
  programs.honkers-launcher.enable = false; # Honkai Impact 3rd
}
