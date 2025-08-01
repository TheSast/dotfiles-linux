require("lazy").setup {
  spec = {
    {
      "AstroNvim/AstroNvim",
      version = "*",
      import = "astronvim.plugins",
      opts = {
        maplocalleader = vim.utils.termcodes "<C-Space>",
      },
    },
    { "AstroNvim/astrocommunity", version = "*" },
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
