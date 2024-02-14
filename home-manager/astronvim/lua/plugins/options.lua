return {
  "astrocore",
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
        background = (tonumber(os.date "%H") >= 18 or tonumber(os.date "%H") < 06) and "dark" or "light",
        cpoptions = string.gsub(vim.o.cpoptions, "_", ""),
        guifont = "FiraCode_Nerd_Font_Med:h12", -- TODO: move to neovide toml file
        pumblend = 30,
        showcmdloc = "statusline",
        title = true,
        titlestring = vim.g.neovide and "Neovide" or "NeoVim",
        winblend = 30,
      },
    },
  },
}
