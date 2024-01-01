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
          vim-nix # adds nix highlighting, auto indentation and file detection
          neo-tree-nvim # File-browser
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
            plugin = nvim-treesitter.withAllGrammars;
            type = "lua";
            config = ''
              require('nvim-treesitter.configs').setup {
                highlight = { enable = true},
                indent = { enable = true }
              }
            '';
          } # Syntax Highlighting
          {
            plugin = dracula-nvim;
            type = "lua";
            config = ''
              require("dracula").setup{}
              vim.cmd[[colorscheme dracula]]
            '';
          } # Dracula Theme installed
          markdown-preview-nvim # Markdown Preview
          plenary-nvim # Dep Needed for Telescope---under the hood this allows easier coroutines to avoid callbacks 
          {
            plugin = telescope-nvim;
            type = "lua";
            config = ''
              local builtin = require('telescope.builtin')
              vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
              vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
              vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
              vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
              require("telescope").setup{}
            '';
          } # telescope the fuzzy finder !!!note!!! : you need ripgrep installed to use.
        ];
        extraConfig = ''
          set number relativenumber
          map <Space> <Leader>
          set expandtab
          set tabstop=2
          set softtabstop=2
          set shiftwidth=2
        '';
      };
    };
  };
}

