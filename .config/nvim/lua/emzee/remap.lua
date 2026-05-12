vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection up" })
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection down" })

vim.api.nvim_set_keymap("n", "<Tab>", "<cmd>bn<CR>", {})
vim.api.nvim_set_keymap("n", "<S-Tab>", "<cmd>bp<CR>", {})

vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y", { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>pc", "\"+p", { desc = "Paste from sytem clipboard" })
vim.keymap.set("n", "<leader>Pc", "\"+P", { desc = "Paste from sytem clipboard" })

vim.keymap.set("n", "<leader>dt", function()
  local date = vim.fn.strftime("%c")
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row, row, true, { date })
end, { desc = "Insert current date and time" })

vim.api.nvim_create_user_command('SetTabWidth', function(opts)
  local n = tonumber(opts.args)
  if not n then
    print("Usage: :SetTabWidth <number>")
    return
  end
  vim.bo.tabstop = n
  vim.bo.shiftwidth = n
  vim.bo.softtabstop = n
  vim.bo.expandtab = true -- Optional: always expand tabs to spaces
  print("Tab width set to " .. n .. " spaces")
end, {
  nargs = 1, -- Require 1 argument
})
