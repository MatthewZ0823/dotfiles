vim.g.mapleader = " "
vim.g.netrw_browsex_viewer = "xdg-open"
vim.g.clipboard = 'osc52'

vim.cmd("set nottimeout")
vim.cmd("set notimeout")

vim.opt.nu = true
vim.opt.relativenumber = true

-- Default tab size
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Define a table of file types
local filetypes = { 'lua', 'c', 'tex', 'dart', 'javascriptreact', 'typescriptreact', 'javascript', 'typescript', 'cpp' }

-- Iterate over the file types and set the options
for _, ft in ipairs(filetypes) do
  vim.cmd(string.format('autocmd FileType %s setlocal shiftwidth=2 softtabstop=2 expandtab', ft))
end

vim.opt.scrolloff = 4

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. [[\undodir]]
vim.opt.undofile = true

vim.keymap.set("n", "<leader>dt", function()
  local date = vim.fn.strftime("%c")
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row, row, true, { date })
end, { desc = "Insert current date and time" })

local function uuid()
  local id, _ = vim.fn.system('uuidgen'):gsub('\n', '')
  return id
end

vim.keymap.set("i", "<C-u>", function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { uuid() })
end, { desc = "Insert a UUID" })
