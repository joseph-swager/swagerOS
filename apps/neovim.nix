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
      neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        defaultEditor = true;
        plugins = with pkgs.vimPlugins; [
          vim-nix
          {
            plugin = vim-commentary;
            config = ''
              let g:hmPlugins='HM_PLUGINS_CONFIG'
            '';
          }
        ];
        extraConfig = ''
          set number relativenumber
        '';
      };
    };
  };
}

