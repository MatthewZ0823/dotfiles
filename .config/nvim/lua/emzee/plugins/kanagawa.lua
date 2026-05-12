local colors = require("kanagawa.colors").setup({ theme = 'wave' })
local palette_colors = colors.palette
local backgroundTransparent = false

local setupDict = {
    keywordStyle = { italic = false },
    commentStyle = { italic = false },
    transparent = backgroundTransparent,
    colors = {
        theme = {
            all = {
                ui = {
                    bg_gutter = palette_colors.sumiInk4
                }
            }
        }
    },
}

-- Configure settings
require('kanagawa').setup(setupDict)

-- Activate Colorscheme
vim.cmd("colorscheme kanagawa-wave")

-- Stuff for toggling background transparency
function ToggleBg()
    backgroundTransparent = not backgroundTransparent

    setupDict.transparent = backgroundTransparent
    if backgroundTransparent then
        setupDict.colors.theme.all.ui.bg_gutter = "none"
    else
        setupDict.colors.theme.all.ui.bg_gutter = palette_colors.sumiInk4
    end

    require('kanagawa').setup(setupDict)
    vim.cmd("colorscheme kanagawa-wave")
end

vim.keymap.set("n", "<leader>tb", ToggleBg, { desc = "Toggle background transparency" })
