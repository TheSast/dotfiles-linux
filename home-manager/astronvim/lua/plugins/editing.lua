return {
  { import = "astrocommunity.lsp.inc-rename-nvim" },
  { import = "astrocommunity.lsp.lsp-inlayhints-nvim" },
  { import = "astrocommunity.lsp.garbage-day-nvim" },
  -- { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
  -- { import = "astrocommunity.diagnostics.trouble-nvim" },
  -- { import = "astrocommunity.fuzzy-finder.telescope-zoxide" },
  -- { import = "astrocommunity.editing-support.telescope-undo-nvim" }, -- WARN: DO NOT UNCOMMET, IS BROKEN, WILL CRIPPLE EDITOR
  {
    "telescope.nvim",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        defaults = {
          windblend = vim.g.neovide and vim.o.winblend,
        },
      })
    end,
  },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
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
  { import = "astrocommunity.editing-support.zen-mode-nvim" },
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
