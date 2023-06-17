return {
  { "TheSast/astrocommunity", name = "Astrofork" },
  { import = "astrocommunity.scrolling.neoscroll-nvim" },
  {
    "AstroNvim/astrotheme",
    event = "VeryLazy",
  },
  {
    "nyngwang/nvimgelion",
    event = "VeryLazy",
  },
  { "AstroNvim/astrocommunity", version = "*" },
  { import = "astrocommunity.bars-and-lines.heirline-mode-text-statusline" },
  { import = "astrocommunity.utility.transparent-nvim" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  {
    "catppuccin",
    event = "VeryLazy",
    opts = {
      flavour = "macchiato",
      background = {
        light = "latte",
        dark = "macchiato",
      },
      styles = {
        comments = { nil },
      },
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
      },
      integrations = {
        markdown = true,
        cmp = true,
      },
    },
  },
  { import = "astrocommunity.colorscheme.everforest" },
  {
    "everforest",
    event = "VeryLazy",
    init = function()
      vim.g.everforest_dim_inactive_windows = 1
      vim.g.everforest_disable_italic_comment = 1
      vim.g.everforest_show_eob = 0
    end,
  },
  { import = "astrocommunity.colorscheme.gruvbox-nvim" },
  {
    "gruvbox.nvim",
    event = "VeryLazy",
    opts = {
      italic = { strings = false, comments = false },
      dim_inactive = true, -- should be called 'lighten_active_if_in_dark_mode'
    },
  },
  { import = "astrocommunity.colorscheme.iceberg-vim" },
  {
    "iceberg.vim",
    event = "VeryLazy",
  },
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },
  {
    "kanagawa.nvim",
    event = "VeryLazy",
    opts = {
      theme = "wave",
      background = {
        dark = "wave",
        light = "lotus",
      },
      commentStyle = { italic = false },
      dimInactive = true,
    },
  },
  { import = "astrocommunity.colorscheme.nord-nvim" },
  {
    "nord.nvim",
    event = "VeryLazy",
  },
  { import = "astrocommunity.colorscheme.oxocarbon-nvim" },
  {
    "oxocarbon.nvim",
    event = "VeryLazy",
  },
  { import = "astrocommunity.colorscheme.rose-pine" },
  {
    "rose-pine",
    event = "VeryLazy",
    opts = {
      disable_float_background = true,
      disable_italics = true,
      dim_nc_background = true, -- does not work
    },
  },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  {
    "tokyonight.nvim",
    event = "VeryLazy",
    opts = {
      style = "storm",
      light_style = "day",
      day_brightness = 0.2,
      styles = {
        comments = { italic = false },
      },
      dim_inactive = true,
    },
  },
  { import = "astrocommunity.colorscheme.vscode-nvim" },
  {
    "vscode.nvim",
    event = "VeryLazy",
    opts = {
      transparent = false,
      italic_comments = false,
    },
  },
}
