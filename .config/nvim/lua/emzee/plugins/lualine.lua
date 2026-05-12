require('lualine').setup({
  sections = {
    lualine_a = { 'branch' },
    lualine_b = { 'diagnostics' },
    lualine_c = { 'diff' },
    lualine_y = {},
    lualine_x = { { 'filename', path = 1 } },
    lualine_z = {},
  }
})
