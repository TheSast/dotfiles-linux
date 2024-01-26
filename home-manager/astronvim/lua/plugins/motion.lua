return {
  { import = "astrocommunity.motion.nvim-spider" },
  ---@type LazySpec
  {
    "nvim-spider",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["ge"] = "<nop>",
              ["x"] = { "<cmd>lua require('spider').motion('ge')<CR>", desc = "Previous end of word" },
            },
            x = {
              ["ge"] = "<nop>",
              ["x"] = { "<cmd>lua require('spider').motion('ge')<CR>", desc = "Previous end of word" },
            },
            o = {
              ["ge"] = "<nop>",
              ["x"] = { "<cmd>lua require('spider').motion('ge')<CR>", desc = "Previous end of word" },
            },
          },
        },
      },
    },
  },
  { import = "astrocommunity.motion.leap-nvim" },
  {
    "leap.nvim",
    -- event = { "User AstroFile", "InsertEnter" },
    opts = {
      safe_labels = {},
    },
    -- dependencies = {
    --   {
    --     "AstroNvim/astrocore",
    --     opts = {
    --       mappings = {
    --         n = {
    --           ["x"] = false,
    --         },
    --         x = {
    --           ["x"] = false,
    --         },
    --         o = {
    --           ["x"] = false,
    --         },
    --       },
    --     },
    --   },
    -- },
  },
  -- { import = "astrocommunity.motion.mini-surround" }, -- TODO: use instead of nvim-surround
  -- {
  --    "mini.surround",
  --    opts = {
  --     mappings = {
  --       add = "Ya", -- Add surrounding in Normal and Visual modes
  --       delete = "Yd", -- Delete surrounding
  --       find = "Yf", -- Find surrounding (to the right)
  --       find_left = "YF", -- Find surrounding (to the left)
  --       highlight = "Yh", -- Highlight surrounding
  --       replace = "Yr", -- Replace surrounding
  --       update_n_lines = "Yn", -- Update `n_lines`
  --     },
  --   },
  -- },
  { import = "astrocommunity.motion.nvim-surround" }, -- TODO: swap for mini.surround
  {
    "nvim-surround",
    opts = {
      keymaps = {
        insert = false,
        insert_line = false,
        normal = "Y",
        normal_cur = false,
        normal_line = false,
        normal_cur_line = false,
        visual = "Y",
        visual_line = false,
        delete = "d" .. "Y",
        change = "c" .. "Y",
        change_line = false,
      },
    },
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = false,
    opts = { useDefaultKeymaps = true },
  },
}
