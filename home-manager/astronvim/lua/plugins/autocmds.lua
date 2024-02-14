return {
  "astrocore",
  opts = {
    autocmds = {
      ["spell-files"] = {
        {
          event = "FileType",
          pattern = { "gitcommit", "markdown", "text", "plaintex" },
          desc = "Text like documents enable wrap and spell",
          callback = function()
            vim.opt_local.wrap = true
            vim.opt_local.spell = true
          end,
        },
      },
    },
  },
}
