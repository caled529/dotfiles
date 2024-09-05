{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (retroarch.override {
      cores = with libretro; [
        beetle-psx-hw
        dolphin
        mupen64plus
        snes9x
      ];
    })
  ];
}
