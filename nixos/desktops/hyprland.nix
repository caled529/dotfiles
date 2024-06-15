{pkgs, ...}: {
  security = {
    pam.services.swaylock.text = "auth include login";
    polkit.enable = true;
  };
  programs.hyprland.enable = true;
}
