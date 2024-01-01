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
          neo-tree-nvim # File-browser
          {
            plugin = vim-commentary;
            config = ''
              let g:hmPlugins='HM_PLUGINS_CONFIG'
            '';
          }
          {
            plugin = lualine-nvim;
            type = "lua";
            config = ''
              local function metals_status()
                return vim.g["metals_status"] or ""
              end
              require('lualine').setup(
                {
                  options = { theme = 'dracula-nvim' },
                  sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff' },
                    lualine_c = { 'filename', metals_status },
                    lualine_x = {'encoding', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                  }
                }
              )
            '';
          }  # Status Line
          {
            plugin = dracula-nvim;
            type = "lua";
            config = ''
              require("dracula").setup{}
              vim.cmd[[colorscheme dracula]]
            '';
          } # Dracula Theme installed
        ];
        extraConfig = ''
          set number relativenumber
          map <Space> <Leader>
        '';
      };
    };
  };
}

