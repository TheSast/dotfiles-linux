return {
  {
    "todo-comments.nvim",
    opts = {
      keywords = {
        TODO = { alt = { "todo", "unimplemented" } },
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
              ["<leader>fT"] = { function() vim.cmd "TodoTelescope" end, desc = "Find TODO, WARN, FIXME, and others" },
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
              ["<leader>z"] = { function() vim.cmd "ZenMode" end, desc = "Enter Zen Mode" },
            },
          },
        },
      },
    },
  },
}
