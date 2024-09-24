{inputs, ...} @ args: {
  imports = [inputs.home-manager.nixosModules.default];
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      hyprExtra = args.hyprExtra;
    };
    users.elac = import ./home.nix;
  };
}
