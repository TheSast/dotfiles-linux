return {
  { import = "astrocommunity.motion.nvim-spider" },
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
  { import = "astrocommunity.motion.mini-surround" },
  {
    -- {[{
    -- NOTE: does not create surroundings text objects, e.g. in `cY2}]` `2}` is handled in a custom way, as are each of the operators in opts.mappings
    -- NOTE: will not implement {count1}{operator}{count2}{motion|textobj}
    -- ISSUE: does not handle registers, unable to be used with "{register} (even "_)
    "mini.surround",
    event = "User AstroFile",
    opts = {
      mappings = { -- should be set by astrocore for better lazyness?
        add = "Y",
        delete = "dY",
        find = "",
        find_left = "",
        highlight = "",
        replace = "cY",
        update_n_lines = "",
        suffix_last = "",
        suffix_next = "",
      },
      respect_selection_type = true,
      n_lines = 100,
      silent = true,
    },
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = false,
    opts = { useDefaultKeymaps = true },
  },
}
