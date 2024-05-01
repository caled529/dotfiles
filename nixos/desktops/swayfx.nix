{pkgs, ...}: {
  security.polkit.enable = true;

  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
    extraPackages = with pkgs; [swaylock swayidle kanshi bemenu waybar wl-clipboard];
    wrapperFeatures.gtk = true;
  };
}
