return {
  {
    "todo-comments.nvim",
    opts = {
      keywords = {
        TODO = { alt = { "todo", "unimplemented", "IDEA" } }, -- todo and unimplemented should be limited to ft=rust files
      },
      highlight = {
        pattern = {
          [[.*<(KEYWORDS)\s*:]],
          [[.*<(KEYWORDS)\s*!\(]],
        },
        comments_only = false,
      },
      search = {
        pattern = [[\b(KEYWORDS)(:|!\()]],
      },
    },
    dependencies = {
      {
        "astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>fT"] = { function() vim.cmd "TodoTelescope" end, desc = "Find TODO, WARN, FIXME, and others" },
            },
          },
        },
      },
    },
  },
  {
    "zen-mode.nvim",
    dependencies = {
      {
        "astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>z"] = { function() vim.cmd "ZenMode" end, desc = "Enter Zen Mode" },
            },
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
