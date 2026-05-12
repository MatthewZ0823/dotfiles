-- This is where all the LSP shenanigans will live
local lsp_zero = require('lsp-zero')
lsp_zero.extend_lspconfig()

vim.o.winborder = 'single'

--- if you want to know more about lsp-zero and mason.nvim
--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  local opts = {
    buffer = bufnr,
    exclude = { "<F2>", "<F3>", "<F4>", "gd" },
  }

  lsp_zero.default_keymaps(opts)

  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, { buffer = bufnr, desc = "Rename" });
  vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { buffer = bufnr, desc = "Code Action" });
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go Definition" });
  vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { buffer = bufnr, desc = "Diagnostic Float" });

  lsp_zero.buffer_autoformat()
end)

local function toggle_autoformat()
  if vim.b.lsp_zero_enable_autoformat == 0 then
    vim.b.lsp_zero_enable_autoformat = 1
  else
    vim.b.lsp_zero_enable_autoformat = 0
  end
end

vim.keymap.set("n", "<leader>af", toggle_autoformat, { desc = "Toggle autoformat on Save" });

require('mason').setup({
  ensure_installed = {
    'black'
  }
})
require('mason-lspconfig').setup({
  ensure_installed = {
    'pyright',
    'lua_ls',
    'clangd',
    'asm_lsp',
    'eslint',
    'jsonls',
    'rust_analyzer',
  },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      -- (Optional) Configure lua language server for neovim
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
    ["asm_lsp"] = function()
      local lspconfig = require('lspconfig')

      -- Configure asm-lsp
      lspconfig.asm_lsp.setup {
        cmd = { "asm-lsp" },
        filetypes = { "asm", "s", "S" }
      }
    end,
    pyright = function()
      require('lspconfig').pyright.setup {
        root_dir = function()
          return vim.fn.getcwd()
        end,
      }
    end,
    elmls = function()
      require('lspconfig').elmls.setup {
        handlers = {
          ["window/showMessageRequest"] = function(whatever, result)
            if result.message:find("Running elm-format failed", 1, true) then
              print(result.message)
              return vim.NIL
            end
            return vim.lsp.handlers["window/showMessageRequest"](whatever, result)
          end,
        },
      }
    end,
    hls = function()
      require('lspconfig').hls.setup {
        -- settings = {
        --   haskell = {
        --     formattingProvider = "stylish-haskell"
        --   }
        -- }
      }
    end,
  }
})
