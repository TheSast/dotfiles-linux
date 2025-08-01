---@type LazySpec
return {
  {
    "nvim-spider",
    dependencies = { -- TODO: add utf8 support
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
    "ggandor/leap.nvim",
    event = "User AstroFile",
    opts = {
      safe_labels = {},
      case_sensitive = true,
      keys = {
        next_target = ";", -- does not overrwite the mapping
        prev_target = ",", -- outside this "LEAP" mode
        next_group = "<NOP>",
        prev_group = "<NOP>",
      },
    },
    init = function() vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) end,
    dependencies = {
      {
        "vim-repeat",
        enable = false, -- the issues with the plugin are not worth the benefits
        -- ISSUE: maps `.`, `u`, `U`, `<C-r>` at the time of loading
      },
      {
        "astrocore",
        ---@type AstroCoreOpts
        opts = {
          mappings = {
            [""] = {
              ["s"] = { "<Plug>(leap-forward)", desc = "Leap forward to" },
              ["S"] = { "<Plug>(leap-backward)", desc = "Leap backward to" },
            },
            n = {
              ["s"] = false,
              ["S"] = false,
            },
            x = {
              ["s"] = false,
              ["S"] = false,
            },
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
  -- {
  --   "ggandor/leap-spooky.nvim",
  --   event = "User AstroFile",
  --   opts = {
  --     -- should be set by astrocore for better lazyness?
  --     extra_text_objects = {
  --       "iw", -- why???
  --       "iW", -- why?????
  --       "iS",
  --       "aS",
  --       "in",
  --       "an",
  --       -- ISSUE iw, iW not working, D, C, Y encounters `timeout`
  --       -- ISSUE multiple textobjects are broken
  --     },
  --     prefix = true,
  --   },
  --   dependencies = "leap.nvim",
  -- },
  -- TODO: https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
  -- "paradigm/vim-multiple-cursor",
  -- "felixr/vim-multiedit",
  -- "hlissner/vim-multiedit",
  -- "adinapoli/vim-markmultiple",
  -- "AndrewRadev/multichange.vim",
  -- {
  --   "terryma/vim-multiple-cursors",
  --   lazy = false,
  --   -- + simple
  --   -- - vimscript, laggy, undo is broken
  -- },
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  --   config = function() vim.g.VM_leader = "Z" end,
  --   -- + popular
  --   -- - vimscript, bad defaults, bloated
  -- },
  -- https://github.com/otavioschwanck/cool-substitute.nvim
  -- https://github.com/YacineDo/mc.nvim
  -- {
  --   "smoka7/multicursors.nvim",
  --   event = "VeryLazy",
  --   dependencies = {
  --     "smoka7/hydra.nvim",
  --   },
  --   opts = {},
  --   cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
  --   -- + lua
  --   -- - depends on hydra
  -- },
}
-- TODO: fix % to not check comments
-- TODO: add motion to select `[ foo bar ] baz` in `[[ foo *ar ] baz ]` -- targets.vim?
-- TODO: consider mini.operators
-- TODO: add a WINDOW_MANAGEMENT mode using hydra.nvim
-- TODO: consider antipatterns https://news.ycombinator.com/item?id=12643887
-- TODO: add iz and az textobj https://github.com/kana/vim-textobj-fold ?
-- xnoremap iz <Cmd>silent!normal![zjV]z<CR>
-- onoremap iz <Cmd>normal viz<CR>
-- xnoremap az <Cmd>silent!normal![zV]zj<CR>
-- onoremap az <Cmd>normal vaz<CR>
