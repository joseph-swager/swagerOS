{
  config,
  lib,
  pkgs,
  ...
}: 
with lib;
{
  home-manager.users.josephs = {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = false;
      nix-direnv.enable = true;
    };
  };
}
