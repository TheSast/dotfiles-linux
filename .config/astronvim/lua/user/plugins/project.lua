return {
  { "AstroNvim/astrocommunity", version = "*" },
  { import = "astrocommunity.file-explorer.oil-nvim" },
  {
    "oil.nvim",
    keys = function()
      return {
        { "<leader>E", function() require("oil").open() end, desc = "Edit folder" },
      }
    end,
  },
}
