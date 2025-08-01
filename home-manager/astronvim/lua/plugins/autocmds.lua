---@type LazySpec
return {
  "astrocore",
  ---@type AstroCoreOpts
  opts = {
    autocmds = {
      ["spell-files"] = {
        {
          event = "FileType",
          pattern = { "gitcommit", "markdown", "text", "plaintex" },
          desc = "Text like documents enable wrap and spell",
          callback = function()
            vim.opt_local.wrap = true
            vim.opt_local.spell = true
          end,
        },
      },
      easy_help = {
        {
          event = "FileType",
          pattern = "help",
          callback = function() vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<C-]>", { noremap = true }) end,
        },
      },
      -- TODO: add auto opt.background! possibly using https://github.com/f-person/auto-dark-mode.nvim and https://askubuntu.com/questions/22313/what-is-dconf-what-is-its-function-and-how-do-i-use-it
      time_based_colorscheme = {
        {
          event = "FocusGained",
          callback = function()
            local correct_bg = (tonumber(os.date "%H") >= 18 or tonumber(os.date "%H") < 06) and "dark" or "light"
            if correct_bg ~= vim.opt.background:get() then require("astrocore.toggles").background() end
          end,
        },
      },
    },
  },
}
-- TODO: add auto opt_local.spelllang!
