return {
  -- { "AstroNvim/astrocommunity", version = "*" },
  { "TheSast/astrocommunity", name = "AstroFork" }, -- TODO: remove
  { import = "astrocommunity.motion.nvim-spider" },
  { import = "astrocommunity.motion.grapple-nvim" },
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
  { import = "astrocommunity.motion.nvim-surround" },
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
