# Miscellaneous game packages and config.
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    lutris
    path-of-building # PoE build planner
    prismlauncher # Minecraft Launcher
  ];
}
