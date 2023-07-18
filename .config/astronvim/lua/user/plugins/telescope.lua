return {
  { "AstroNvim/astrocommunity", version = "*" },
  { import = "astrocommunity.editing-support.telescope-undo-nvim" },
  {
    "telescope.nvim",
    dependencies = {
      "jvgrootveld/telescope-zoxide",
    },
    keys = {
      {
        "<leader>fz",
        "<cmd>Telescope zoxide list<CR>",
        desc = "Find directories",
      },
    },
    opts = function(_, opts)
      require("telescope").load_extension "zoxide"
      return require("astronvim.utils").extend_tbl(opts, {
        defaults = {
          winblend = vim.g.neovide and vim.o.winblend,
        },
      })
    end,
  },
}
