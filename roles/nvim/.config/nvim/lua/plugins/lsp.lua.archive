return {
  -- https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    keys = {
      { "<leader>cl", "<cmd>LspInfo<cr>",                          desc = "::LSP Info" },
      { "gd",         "<cmd>lua vim.lsp.buf.definition()<cr>",     desc = "::LSP Goto Definition" },
      { "gn",         "<cmd>lua vim.lsp.buf.rename()<cr>",         desc = "::LSP Rename" },
      { "K",          "<cmd>lua vim.lsp.buf.hover()<cr>",          desc = "::LSP Hover" },
      -- { "<c-k>",      "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "::LSP Signature Help" },
      { "<c-k>",      "<cmd>lua vim.diagnostic.open_float()<cr>",  desc = "::LSP Diagnostic Open float" },
      { "gi",         "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "::LSP Goto Implementation" },
      { "gr",         "<cmd>lua vim.lsp.buf.references()<cr>",     desc = "::LSP References" },
      { "gf",         "<cmd>lua vim.lsp.buf.format()<cr>",         desc = "::LSP Format" },
      { "gl",         "<cmd>lua vim.diagnostic.setloclist()<cr>",  desc = "::LSP Diagnostic Location List" },
      { "<c-n>",      "<cmd>lua vim.diagnostic.goto_next()<cr>",   desc = "::LSP Diagnostic Goto Next" },
      { "<c-p>",      "<cmd>lua vim.diagnostic.goto_prev()<cr>",   desc = "::LSP Diagnostic Goto Prev" },
    },

    config = function()
      -- https://vi.stackexchange.com/questions/39074/user-borders-around-lsp-floating-windows
      require('lspconfig.ui.windows').default_options.border = 'single'
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = 'single'
        }
      )
      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = 'single'
        }
      )

      vim.diagnostic.config({
        signs = true,             -- true: LSP サインを表示する
        virtual_text = false,     -- false: 仮想テキスト（エラー説明）を表示しない
        underline = true,         -- true: エラー行に下線を表示する
        update_in_insert = false, -- false: 挿入モードのときに diagnostic を更新させない
        severity_sort = true,     -- true: エラー/警告/ヒントの表示順を深刻度の高い方から表示する（サインカラムにそれらが重なった場合）
        float = {
          source = "always",      -- Or "if_many"
          border = 'single'
        },
      })

      -- LspAttach: LSP Server が開いた Buffer に Attach されたときに発火
      -- https://www.mitchellhanberg.com/modern-format-on-save-in-neovim/
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("Lsp", { clear = true }),
        callback = function(args)
          vim.api.nvim_create_autocmd("BufWritePre", {
            -- pattern = { "*.py" }, -- NOTE: none-ls でフォーマットしない拡張子のみ設定（通常、none-ls でフォーマットするが、一部専用の LS で対応するものがあるため）
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format { async = false, id = args.data.client_id }
            end,
          })
        end
      })
    end
  },

  -- https://github.com/williamboman/mason.nvim
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup {
        ui = {
          border = 'single'
        }
      }
    end
  },

  -- https://github.com/williamboman/mason-lspconfig.nvim
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "neovim/nvim-lspconfig", },
      { "hrsh7th/cmp-nvim-lsp", }, -- LSP source for nvim-cmp
    },
    config = function()
      -- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",                          -- Lua
          "phpactor",                        -- php
          "pylsp",                           -- Python
          "ruff",                            -- ruff(Python linter, formatter)
          "gopls",                           -- Go
          "ts_ls",                           -- TypeScript
          "marksman",                        -- Markdown
          "bashls",                          -- Bash
          "html",                            -- HTML
          "jsonls",                          -- Json
          "cssls",                           -- CSS
          "dockerls",                        -- Docker
          "docker_compose_language_service", --Docker Compose
        },
      }

      local lspconfig = require("lspconfig")
      local handlers = {
        function(server_name)
          lspconfig[server_name].setup {
            -- https://github.com/hrsh7th/cmp-nvim-lsp?tab=readme-ov-file#capabilities
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
          }
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup {
            settings = {
              Lua = {
                -- Fix: Undefined global `vim` of lua_ls warning
                diagnostics = {
                  globals = { "vim" }
                }
              }
            }
          }
        end,
      }
      require("mason-lspconfig").setup_handlers(handlers)
    end
  },

  -- https://github.com/nvimtools/none-ls.nvim
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      -- https://github.com/nvim-lua/plenary.nvim
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      null_ls.setup {
        sources = {
          -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#phpcsfixer
          null_ls.builtins.formatting.phpcsfixer,
        },
        -- https://github.com/nvimtools/none-ls.nvim/wiki/Formatting-on-save#code
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
      }
    end
  },

  -- https://github.com/ray-x/lsp_signature.nvim
  {
    "ray-x/lsp_signature.nvim",
    opts = {},
    config = function(_, opts)
      require 'lsp_signature'.setup(opts)
    end
  },

  -- https://github.com/RRethy/vim-illuminate
  {
    "RRethy/vim-illuminate",
    config = function()
      require 'illuminate'.configure({
        vim.api.nvim_create_autocmd("BufReadPost", {
          group = vim.api.nvim_create_augroup("Change_Illuminate", { clear = true }),
          callback = function()
            vim.cmd([[hi IlluminatedWordText cterm=underline gui=undercurl]])
            vim.cmd([[hi IlluminatedWordRead cterm=underline gui=undercurl]])
            vim.cmd([[hi IlluminatedWordWrite cterm=underline gui=undercurl]])
          end,
          desc = "Change Illuminate Highlights",
        })
      })
    end
  },

  -- Autocompletion plugin
  -- https://github.com/hrsh7th/nvim-cmp/
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- https://github.com/hrsh7th/cmp-path
      { "hrsh7th/cmp-path" },
      -- https://github.com/hrsh7th/vim-vsnip
      { "hrsh7th/vim-vsnip" },
      -- https://github.com/hrsh7th/cmp-vsnip
      { "hrsh7th/cmp-vsnip" },
      -- https://github.com/rafamadriz/friendly-snippets
      { "rafamadriz/friendly-snippets" },
      -- https://github.com/windwp/nvim-autopairs
      { 'windwp/nvim-autopairs' },
    },
    config = function()
      -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#vim-vsnip
      -- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#nvim-cmp
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      local cmp = require("cmp")
      cmp.setup {
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'vsnip' }, -- For vsnip users.
        }, {
          { name = 'buffer' },
        }),
        mapping = cmp.mapping.preset.insert({
          ['<c-l>'] = cmp.mapping.complete(),                -- 補完候補表示
          ['<cr>'] = cmp.mapping.confirm({ select = true }), -- 補完の選択確定（デフォルト c-y も使える）
          ["<c-p>"] = cmp.mapping.select_prev_item(),        -- 補完欄を一つ上に移動（デフォルトだが明示した）
          ["<c-n>"] = cmp.mapping.select_next_item(),        -- 補完欄を一つ下に移動（デフォルトだが明示した）
          ['<c-f>'] = cmp.mapping.scroll_docs(4),            -- 補完欄内を下に移動
          ['<c-b>'] = cmp.mapping.scroll_docs(-4),           -- 補完欄内を上に移動
          ['<Tab>'] = cmp.mapping(function(fallback)         -- Super-Tab like mapping: Tab で補完欄を一つ下に移動
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
              feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback) -- Super-Tab like mapping: S-Tab で補完欄を一つ上に移動
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              feedkey("<Plug>(vsnip-jump-prev)", "")
            end
          end, { 'i', 's' }),
        })
      }

      -- https://github.com/windwp/nvim-autopairs?tab=readme-ov-file#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end
  },

  -- https://github.com/folke/trouble.nvim
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      { "<leader>x", "<cmd>Trouble diagnostics toggle<cr>", desc = "::Trouble Diagnostics (Trouble)" },
    },
  }

}
