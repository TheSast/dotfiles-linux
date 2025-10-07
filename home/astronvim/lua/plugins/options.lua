---@type LazySpec
return {
  "astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      g = {
        neovide_floating_blur_amount_x = 2.0,
        neovide_floating_blur_amount_y = 2.0,
        neovide_hide_mouse_when_typing = true,
        neovide_no_idle = false,
        neovide_refresh_rate_idle = 5,
        neovide_underline_automatic_scaling = true,
      },
      opt = {
        cedit = vim.utils.termcodes "<Esc>",
        cpoptions = vim.o.cpoptions:gsub("_", "") .. "%",
        guifont = "FiraCode_Nerd_Font_Med:h12", -- TODO: move to neovide toml file
        -- iskeyword = "", -- ISSUE: breaks todo-comments
        matchpairs = vim.o.matchpairs .. ",<:>",
        maxmapdepth = 3,
        pumblend = 30,
        showcmdloc = "statusline",
        title = true,
        titlestring = vim.g.neovide and "Neovide" or "NeoVim",
        whichwrap = "",
        wildchar = 0,
        winblend = 30,
      },
    },
  },
}
