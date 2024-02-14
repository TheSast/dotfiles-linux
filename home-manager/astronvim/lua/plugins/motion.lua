return {
  {
    "nvim-spider",
    dependencies = {
      "astrocore",
      opts = {
        mappings = {
          n = {
            ["w"] = { "<Cmd>lua require('spider').motion('w')<CR>", desc = "Next word" },
            ["e"] = { "<Cmd>lua require('spider').motion('e')<CR>", desc = "Next end of word" },
            ["b"] = { "<Cmd>lua require('spider').motion('b')<CR>", desc = "Previous word" },
            ["x"] = { "<Cmd>lua require('spider').motion('ge')<CR>", desc = "Previous end of word" },
          },
          x = {
            ["w"] = { "<Cmd>lua require('spider').motion('w')<CR>", desc = "Next word" },
            ["e"] = { "<Cmd>lua require('spider').motion('e')<CR>", desc = "Next end of word" },
            ["b"] = { "<Cmd>lua require('spider').motion('b')<CR>", desc = "Previous word" },
            ["x"] = { "<Cmd>lua require('spider').motion('ge')<CR>", desc = "Previous end of word" },
          },
          o = {
            ["w"] = { "<Cmd>lua require('spider').motion('w')<CR>", desc = "Next word" },
            ["e"] = { "<Cmd>lua require('spider').motion('e')<CR>", desc = "Next end of word" },
            ["b"] = { "<Cmd>lua require('spider').motion('b')<CR>", desc = "Previous word" },
            ["x"] = { "<Cmd>lua require('spider').motion('ge')<CR>", desc = "Previous end of word" },
          },
        },
      },
    },
  },
  {
    "leap.nvim",
    event = "User AstroFile",
    opts = {
      safe_labels = {},
    },
    dependencies = {
      "astrocore",
      opts = {
        mappings = {
          n = {
            ["s"] = { "<Plug>(leap-forward-to)", desc = "Leap forward to" },
            ["S"] = { "<Plug>(leap-backward-to)", desc = "Leap backward to" },
            ["gs"] = { "<Plug>(leap-from-window)", desc = "Leap from window" },
          },
          x = {
            ["s"] = { "<Plug>(leap-forward-to)", desc = "Leap forward to" },
            ["S"] = { "<Plug>(leap-backward-to)", desc = "Leap backward to" },
            ["gs"] = { "<Plug>(leap-from-window)", desc = "Leap from window" },
          },
          o = {
            ["s"] = { "<Plug>(leap-forward-to)", desc = "Leap forward to" },
            ["S"] = { "<Plug>(leap-backward-to)", desc = "Leap backward to" },
            ["gs"] = { "<Plug>(leap-from-window)", desc = "Leap from window" },
          },
        },
      },
    },
  },
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
    "backdround/improved-ft.nvim",
    event = "User AstroFile",
    opts = {
      use_default_mappings = true, -- should be set by astrocore for better lazyness?
      use_relative_repetition = true,
      use_relative_repetition_offsets = true,
    },
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = false,
    opts = { useDefaultKeymaps = true },
  },
}
