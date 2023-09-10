return {
  { "AstroNvim/astrocommunity", version = "*" },
  { import = "astrocommunity.motion.nvim-spider" },
  { import = "astrocommunity.motion.vim-matchup" },
  { import = "astrocommunity.motion.grapple-nvim" },
  -- Possible replacement for leap or complementary plugin to it
  -- { import = "astrocommunity.motion.flash-nvim" },
  -- {
  --   "flash.nvim",
  --   enable = false,
  --   keys = function() return {} end,
  -- },
  {
    "folke/flash.nvim",
    enable = true,
    opts = {},
    keys = {
      {
        "<C-s>",
        function()
          local Flash = require("flash")
          
          ---@param opts Flash.Format
          local function format(opts)
            -- always show first and second label
            return {
              { opts.match.label1, "FlashMatch" },
              { opts.match.label2, "FlashLabel" },
            }
          end
          
          Flash.jump({
            search = { mode = "search" },
            label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
            pattern = [[\<]],
            action = function(match, state)
              state:hide()
              Flash.jump({
                search = { max_length = 0 },
                highlight = { matches = false },
                label = { format = format },
                matcher = function(win)
                  -- limit matches to the current label
                  return vim.tbl_filter(function(m)
                    return m.label == match.label and m.win == win
                  end, state.results)
                end,
                labeler = function(matches)
                  for _, m in ipairs(matches) do
                    m.label = m.label2 -- use the second label
                  end
                end,
              })
            end,
            labeler = function(matches, state)
              local labels = state:labels()
              for m, match in ipairs(matches) do
                match.label1 = labels[math.floor((m - 1) / #labels) + 1]
                match.label2 = labels[(m - 1) % #labels + 1]
                match.label = match.label1
              end
            end,
          })
          end
      }
    },
  },
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
  {
	  "chrisgrieser/nvim-various-textobjs",
	  lazy = false,
	  opts = { useDefaultKeymaps = true },
  },
}
