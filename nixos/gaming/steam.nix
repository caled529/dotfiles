{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Add libraries necessary for games in here
    ];
  };
}
