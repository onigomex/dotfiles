return {
  -- https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    keys = {
      { "<leader>cl", "<cmd>LspInfo<cr>", desc = "::LSP Info" },
      { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "::LSP Goto Definition" },
      { "gn", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "::LSP Rename" },
      { "K", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "::LSP Hover" },
      { "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "::LSP Signature Help" },
      { "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "::LSP Goto Implementation" },
      { "gr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "::LSP References" },
      { "go", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "::LSP Diagnostic Open float" },
      { "gl", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "::LSP Diagnostic Location List" },
      { "<C-n>", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "::LSP Diagnostic Goto Next" },
      { "<C-p>", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "::LSP Diagnostic Goto Prev" },
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
        signs = true, -- true: LSP サインを表示する
        virtual_text = false, -- false: 仮想テキスト（エラー説明）を表示しない
        underline = true, -- true: エラー行に下線を表示する
        update_in_insert = false, -- false: 挿入モードのときに diagnostic を更新させない
        severity_sort = true, -- true: エラー/警告/ヒントの表示順を深刻度の高い方から表示する（サインカラムにそれらが重なった場合）
        float = {
          source = "always", -- Or "if_many"
          border = 'single'
        },
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
    },
    config = function()
      -- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls", -- Lua
          "phpactor", -- php
          "gopls", -- Go
        },
      }

      local lspconfig = require("lspconfig")
      local handlers = {
        function(server_name)
          lspconfig[server_name].setup {}
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

}