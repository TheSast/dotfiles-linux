return {
  -- { "AstroNvim/astrocommunity", version = "*" },
  { "TheSast/astrocommunity", name = "AstroFork" }, -- TODO: remove
  { import = "astrocommunity.motion.nvim-spider" },
  { import = "astrocommunity.motion.grapple-nvim" },
  -- Possible replacement for leap or complementary plugin to it
  -- { import = "astrocommunity.motion.flash-nvim" },
  -- {
  --   "flash.nvim",
  --   enable = false,
  --   keys = function() return {} end,
  -- },
  { import = "astrocommunity.motion.leap-nvim" },
  {
    "leap.nvim",
    keys = function()
      return {
        {
          "s",
          "<Plug>(leap-forward-to)",
          mode = { "n", "x", "o" },
          desc = "Leap forward to",
        },
        {
          "S",
          "<Plug>(leap-backward-to)",
          mode = { "n", "x", "o" },
          desc = "Leap backward to",
        },
      }
    end,
    opts = {
      safe_labels = {},
    },
  },
  -- { import = "astrocommunity.motion.mini-surround" }, -- TODO: use instead of nvim-surround
  -- {
  -- "mini.surround"
  --    opts = {
  --   mappings = {
  --     add = "gsa", -- Add surrounding in Normal and Visual modes
  --     delete = "gsd", -- Delete surrounding
  --     find = "gsf", -- Find surrounding (to the right)
  --     find_left = "gsF", -- Find surrounding (to the left)
  --     highlight = "gsh", -- Highlight surrounding
  --     replace = "gsr", -- Replace surrounding
  --     update_n_lines = "gsn", -- Update `n_lines`
  --   },
  -- },
  -- }
  { import = "astrocommunity.motion.nvim-surround" }, -- TODO: swap for mini.surround
  {
    "nvim-surround",
    opts = {
      keymaps = {
        insert = false,
        insert_line = false,
        normal = "gs",
        normal_cur = false,
        normal_line = false,
        normal_cur_line = false,
        visual = "gs",
        visual_line = false,
        delete = "d" .. "gs",
        change = "c" .. "gs",
        change_line = false,
      },
    },
  },
  { import = "astrocommunity.motion.portal-nvim" },
  {
    "portal.nvim",
    keys = function()
      return {
        {
          "g" .. "<C-o>",
          "<cmd>Portal jumplist backward<CR>",
          desc = "Portal Jump backward",
        },
        {
          "g" .. "<C-i>",
          "<cmd>Portal jumplist forward<CR>",
          desc = "Portal Jump forward",
        },
      }
    end,
  },
  { import = "astrocommunity.motion.mini-move" },
}
