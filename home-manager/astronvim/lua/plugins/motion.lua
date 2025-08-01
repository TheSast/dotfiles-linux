---@type LazySpec
return {
  {
    -- TODO: open an issue to make it possible to configure whether a motion is current and/or target inclusive/exclusive
    "chrisgrieser/nvim-spider",
    opts = {
      consistentOperatorPending = true,
    },
    dependencies = {
      {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        opts = {
          rocks = { "luautf8" },
        },
      },
      {
        "astrocore",
        ---@type AstroCoreOpts
        opts = {
          -- IDEA: add a `w` version that counts kebab-cased and pascalCased delimited words as one
          mappings = {
            [""] = {
              ["<Plug>(spider-w)"] = { function() require("spider").motion "w" end, desc = "Next word" },
              ["<Plug>(spider-e)"] = { function() require("spider").motion "e" end, desc = "Next end of word" },
              ["<Plug>(spider-b)"] = { function() require("spider").motion "b" end, desc = "Previous word" },
              ["<Plug>(spider-ge)"] = { function() require("spider").motion "ge" end, desc = "Previous end of word" },
              ["w"] = { "<Plug>(spider-w)", desc = "Next word" },
              ["e"] = { "<Plug>(spider-e)", desc = "Next end of word" },
              ["b"] = { "<Plug>(spider-b)", desc = "Previous word" },
              ["x"] = { "<Plug>(spider-ge)", desc = "Previous end of word" },
            },
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
  -- TODO: https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
  -- after tyring *all* of the available multiple cursor plugins, it is clear none can match helix's implementation
}
-- TODO: fix % to not check comments
-- TODO: remove default % (#if #endif), consider https://github.com/theHamsta/nvim-treesitter-pairs https://github.com/andymass/vim-matchup
-- TODO: add a WINDOW_MANAGEMENT mode using hydra.nvim
-- TODO: consider antipatterns https://news.ycombinator.com/item?id=12643887
-- TODO: add iz and az textobj https://github.com/kana/vim-textobj-fold ?
-- xnoremap iz <Cmd>silent!normal![zjV]z<CR>
-- onoremap iz <Cmd>normal viz<CR>
-- xnoremap az <Cmd>silent!normal![zV]zj<CR>
-- onoremap az <Cmd>normal vaz<CR>
-- TODO: consider https://github.com/XXiaoA/ns-textobject.nvim
-- TODO: consider https://github.com/chaoren/vim-wordmotion
