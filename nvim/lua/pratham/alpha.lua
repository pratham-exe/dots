local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {

'                                                  ',
'                                                  ',
'                                                  ',
'                                                  ',
'                                                  ',
'                                                  ',
'███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
'████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
'██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
'██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
'██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
'╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
'                                                  ',
'                                                  ',
'                                                  ',
'                                                  ',
'                                                  ',
'                                                  ',
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "l", "  LeetCode", ":Leet <CR>"),
    dashboard.button( "o", "  Browse file", ":Oil<CR>"),
    dashboard.button( "q", "󰗼  Quit NVIM", ":qa<CR>"),
}

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
