return {
  "kmonad/kmonad-vim",
  { "AstroNvim/astrocommunity", version = "*" },

  -- completion
  -- { import = "astrocommunity.completion.codeium-vim" }, -- dunno, command not workin

  -- git
  -- { import = "astrocommunity.git.openingh" },
  -- { import = 'astrocommunity.git.octo' }, -- <leader>O taken

  -- diagnostics
  { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
}
