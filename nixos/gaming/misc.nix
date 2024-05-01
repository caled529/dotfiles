# Miscellaneous game packages and config.
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    lutris
    mupen64plus # N64 Emulator
    prismlauncher # Minecraft Launcher
  ];
}
