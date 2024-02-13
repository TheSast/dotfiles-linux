return {
  { import = "astrocommunity.utility.noice-nvim" },
  {
    "noice.nvim",
    enabled = true, -- commands such as `:set timeoutlen?` don't show input, may disable sometimes
    opts = {
      cmdline = {
        format = {
          lua = false,
        },
      },
      messages = {
        enabled = false,
      },
      lsp = {
        signature = {
          enabled = false, -- FIXME: something else is attempting to handle this
        },
        hover = {
          enabled = false, -- FIXME: something else is attempting to handle this
        },
      },
    },
  },
}
