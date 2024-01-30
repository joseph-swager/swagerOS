{ config, lib, pkgs, ... }:
with lib; {
  home-manager.users.josephs = {
    programs = {
      direnv = {
        enable = true;
        enableBashIntegration = true;
        nix-direnv.enable = true;
      };
    };
  };
}
