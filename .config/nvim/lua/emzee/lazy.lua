-- Boot Strap Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup and install packages
require("lazy").setup({
  {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    lazy = false,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require('which-key').setup()
    end,
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git" },
    keys = {
      { "<leader>gs", function() vim.cmd("below Git") end, desc = "Fugitive" },
    }
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "rafamadriz/friendly-snippets" },
      { "saadparwaiz1/cmp_luasnip" },
      { "L3MON4D3/LuaSnip" },
    },
    config = function()
      require("emzee.plugins.lsp.nvim-cmp")
    end
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      require("emzee.plugins.lsp.nvim-lspconfig")
    end
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    keys = {
      { "<leader>e", "<cmd>Oil<cr>", desc = "Open parent directory" }
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons"
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh" },
    opts = {},
    keys = {
      { "<leader>tt", "<cmd>Trouble diagnostics toggle focus=true<cr>",            desc = "Toggle Trouble" },
      { "gR",         "<cmd>Trouble lsp toggle focus=true win.position=right<cr>", desc = "LSP References" },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    'numToStr/Comment.nvim',
    keys = {
      { "gc", mode = { "n", "v" } },
      { "gb", mode = { "n", "v" } },
    },
    lazy = true,
    config = function()
      require("Comment").setup()
    end,
  },
  {
    'lervag/vimtex',
    event = "VeryLazy",
    config = function()
      require("emzee.plugins.vimtex")
    end,
  },
  {
    'akinsho/flutter-tools.nvim',
    -- dir = vim.fn.stdpath("data") .. [[\local-plugins\flutter-tools.nvim]],
    name = "flutter-tools",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    lazy = false,
    config = function()
      require("emzee.plugins.flutter-tools")
    end,
  },
  {
    "chrisbra/Colorizer",
    lazy = false,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = "BufEnter",
    config = function()
      require("emzee.plugins.null-ls")
    end,
  },
  {
    "moll/vim-bbye",
    lazy = true,
    keys = {
      { "<leader>x", "<cmd>Bdelete<CR>",  desc = "Delete buffer" },
      { "<leader>X", "<cmd>Bdelete!<CR>", desc = "Force delete buffer" }
    }
  },
  {
    "mbbill/undotree",
    lazy = true,
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle, desc = "Undotree Toggle" }
    },
    config = function()
      require("emzee.plugins.undotree")
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },
  {
    'mfussenegger/nvim-dap',
    lazy = false,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    opts = {
      theme = 'gruvbox',
    },
    config = function()
      require('emzee.plugins.lualine')
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup()
      vim.diagnostic.config({ virtual_text = false, severity_sort = true }) -- Disable Neovim's default virtual text diagnostics
    end,
  }
})
