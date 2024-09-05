# Miscellaneous game packages and config.
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    lutris
    prismlauncher # Minecraft Launcher
  ];
}
