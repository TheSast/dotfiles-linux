---@type LazySpec
return {
  {
    "monkoose/matchparen.nvim",
    lazy = false,
    opts = {},
  },
  {
    "zen-mode.nvim",
    dependencies = {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<Leader>z"] = { function() vim.cmd "ZenMode" end, desc = "Enter Zen Mode" },
          },
        },
      },
    },
  },
}
-- TODO: setup
-- {
--   "dial.nvim",
--   dependencies = {
--     "astrocore",
--     opts = {
--       mappings = {
--         n = {
--           { "+", require("dial.map").manipulate("increment", "normal"), desc = "Increment" },
--           { "-", require("dial.map").manipulate("decrement", "normal"), desc = "Decrement" },
--           { "g+", require("dial.map").manipulate("increment", "gnormal"), desc = "Increment" },
--           { "g-", require("dial.map").manipulate("decrement", "gnormal"), desc = "Decrement" },
--         },
--         x = {
--           { "+", require("dial.map").manipulate("increment", "visual"), desc = "Increment" },
--           { "-", require("dial.map").manipulate("decrement", "visual"), desc = "Decrement" },
--           { "g+", require("dial.map").manipulate("increment", "gvisual"), desc = "Increment" },
--           { "g-", require("dial.map").manipulate("decrement", "gvisual"), desc = "Decrement" },
--         },
--       },
--     },
--   },
-- },
-- TODO: consider nvim-lightbulb
-- TODO: consider vim-radical or more maintained alternatives
-- TODO: consider vim-case-changer or more maintained alternatives
-- TODO: consider https://github.com/iamcco/markdown-preview.nvim (maybe-lang?)
-- TODO: consider neogen
-- TODO: consider undotree
-- TODO: consider https://github.com/luckasRanarison/nvim-devdocs (maybe-lang?)
-- TODO: consider https://github.com/nanotee/zoxide.vim
