local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

vim.keymap.set('n', '<leader>fa', function() builtin.find_files({ hidden = true, no_ignore = true }) end,
  { desc = "Find all files" })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffers" })
vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = "Find word" })
vim.keymap.set('n', '<leader>fl', builtin.lsp_document_symbols, { desc = "Find LSP Symbols" })
vim.keymap.set('n', '<leader>fs', builtin.spell_suggest, { desc = "Find spelling" })

require('telescope').setup({
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close,
      },
      i = {
        ["<Esc>"] = actions.close,
        ["<C-c>"] = actions.close,
      },
    },
  },
})
