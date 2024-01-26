-- Default options that are always set: https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/options.lua
local background
if tonumber(os.date "%H") >= 18 or tonumber(os.date "%H") < 06 then
  background = "dark"
else
  background = "light"
end

-- vim.g.mapleader = " " -- sets vim.g.mapleader
vim.opt.showcmdloc = "statusline"
vim.opt.title = true
vim.opt.titlestring = "NeoVim"
vim.opt.guifont = "FiraCode_Nerd_Font_Med:h12"
vim.opt.winblend = 30
vim.opt.pumblend = 30
-- vim.opt.linespace = -1
vim.opt.background = background
-- vim.opt.cpoptions = vim.opt.cpoptions:remove "_" --[[or]] -- :gsub("_" "")
vim.opt.cpoptions = "aABceFs"
-- vim.g.maplocalleader = "<C-Space>"
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
-- vim.g.neovide_transparency = 0.9
vim.g.neovide_scroll_animation_length = 0.35
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_underline_automatic_scaling = true
vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_left = 0
vim.g.neovide_refresh_rate = 165
vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_no_idle = false
vim.g.neovide_cursor_animation_length = 0.05
-- vim.g.neovide_cursor_animation_length = 0.13
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_animate_animate_command_line = false
vim.g.neovide_cursor_unfocused_outline_width = 0.125
vim.g.neovide_cursor_vfx_mode = ""
