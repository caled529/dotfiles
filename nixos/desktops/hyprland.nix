{pkgs, ...}: {
  security = {
    pam.services.swaylock.text = "auth include login";
    polkit.enable = true;
  };
  programs.hyprland.enable = true;
  # Fix screen sharing from apps running under XWayland (Discord)
  environment.systemPackages = [pkgs.xwaylandvideobridge];
}
