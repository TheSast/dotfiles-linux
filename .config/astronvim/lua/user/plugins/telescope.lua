return {
  "telescope.nvim",
  dependencies = {
    "jvgrootveld/telescope-zoxide",
    "debugloop/telescope-undo.nvim",
    opts = function(_, opts)
      return require("astronvim.utils").extend_tbl(opts, {
        defaults = {
          winblend = vim.g.neovide and vim.o.winblend,
        },
      })
    end,
  },
  keys = {
    { "<leader>fz", "<cmd>Telescope zoxide list<CR>", desc = "Find directories" },
    { "<leader>fu", "<cmd>Telescope undo<CR>", desc = "Find undos" },
  },
  config = function(...)
    require "plugins.configs.telescope"(...)
    local telescope = require "telescope"
    telescope.load_extension "zoxide"
    telescope.load_extension "undo"
  end,
}
