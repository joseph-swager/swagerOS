{
  config,
  lib,
  pkgs,
  ...
}: 
with lib;
{
  home-manager.users.josephs = {
    programs = {
      kitty = {
        enable = true;
        font.name = "JetBrainsMono Nerd Font";
        font.size = 16;
      };
    };
  };
}
