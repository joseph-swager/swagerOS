{ config, lib, pkgs, ... }:
with lib; {
  home-manager.users.josephs = {
    programs = {
      neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        defaultEditor = true;
        plugins = with pkgs.vimPlugins; [
          vim-nix # adds nix highlighting, auto indentation and file detection
          nvim-web-devicons # need for icon in neo-tree
          {
            plugin = neo-tree-nvim;
            type = "lua";
            config = ''
              vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})
            '';
          } # File-browser
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
          } # Status Line
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
          {
            plugin = telescope-ui-select-nvim;
            type = "lua";
            config = ''
              require("telescope").setup {
                extensions = {
                  ["ui-select"] = {
                    require("telescope.themes").get_dropdown {
                    -- even more opts
                    }

                  }
                }
              }
              require("telescope").load_extension("ui-select")
            '';
          }
          {
            plugin = nvim-lspconfig;
            type = "lua";
            config = ''
              local lspconfig = require('lspconfig')
              lspconfig.lua_ls.setup {}
              lspconfig.nixd.setup {}
              lspconfig.pyright.setup {}
              lspconfig.clojure_lsp.setup {}
              lspconfig.java_language_server.setup {}
              vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
              vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {})
              vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
              vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
              vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
              vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
              vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {})
              vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})
              vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, {})
            '';
          } # lsp setup
          luasnip # enables Snippets
          cmp_luasnip # luasnip completion source for nvim-cmp
          cmp-nvim-lsp # nvim-cmp source for neovim's built-in language server client.
          {
            plugin = nvim-cmp;
            type = "lua";
            config = ''
              local capabilities = require("cmp_nvim_lsp").default_capabilities()

              local lspconfig = require('lspconfig')
              local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
              for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup {
                  -- on_attach = my_custom_on_attach,
                  capabilities = capabilities,
                }
              end

              local luasnip = require 'luasnip'

              local cmp = require 'cmp'
              cmp.setup {
                snippet = {
                  expand = function(args)
                    luasnip.lsp_expand(args.body)
                  end,
                },
              mapping = cmp.mapping.preset.insert({
                ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
                ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
                -- C-b (back) C-f (forward) for snippet placeholder navigation.
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm {
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = true,
                },
                ['<Tab>'] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                  else
                    fallback()
                  end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                  else
                    fallback()
                  end
                end, { 'i', 's' }),
              }),
              sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
              },
              }
            '';
          }
          {
            plugin = bufferline-nvim;
            type = "lua";
            config = ''
              require("bufferline").setup{}
            '';
          } # A snazzy buffer line thats copied the aesthetics of  doom emacs
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

