require("lazy").setup {
  spec = {
    -- TODO: change `branch="v4"` to `version="^4"` and `version=^6` respectively on release
    {
      "AstroNvim/AstroNvim",
      branch = "v4",
      import = "astronvim.plugins",
      opts = {
        maplocalleader = vim.utils.termcodes "<C-Space>",
      },
    },
    { "AstroNvim/astrocommunity", branch = "v4" },
    { import = "plugins" },
  },
  change_detection = { notify = false },
  defaults = { lazy = true },
  install = { colorscheme = { "habamax" } },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}
