{
  config,
  intelBusId,
  nvidiaBusId,
  ...
}: {
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidiaSettings = true;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = intelBusId;
      nvidiaBusId = nvidiaBusId;
    };
  };

  services.xserver.videoDrivers = ["nvidia"];
}
