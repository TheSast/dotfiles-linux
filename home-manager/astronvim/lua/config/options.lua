vim.g.maplocalleader = vim.api.nvim_replace_termcodes("<C-Space>", true, true, true)
vim.opt.showcmdloc = "statusline"
vim.opt.title = true
vim.opt.background = (tonumber(os.date "%H") >= 18 or tonumber(os.date "%H") < 06) and "dark" or "light"
vim.opt.cpoptions:remove "_"
vim.opt.titlestring = vim.g.neovide and "Neovide" or "NeoVim"
vim.opt.guifont = "FiraCode_Nerd_Font_Med:h12" -- TODO: move to neovide toml file
vim.opt.winblend = 30
vim.opt.pumblend = 30
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_underline_automatic_scaling = true
vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_no_idle = false
