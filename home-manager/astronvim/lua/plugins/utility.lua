return {
  {
    "noice.nvim",
    enabled = false, -- commands such as `:set timeoutlen?` don't show input, may disable sometimes
    opts = {
      cmdline = {
        format = {
          lua = false,
        },
      },
      messages = {
        -- enabled = false,
        view = "cmdline",
        view_error = "cmdline",
        view_warn = "cmdline",
        -- view_history = "cmdline",
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
    dependencies = { -- TODO: add this to astrocommunity
      "heirline.nvim",
      optional = true,
      opts = function(_, opts) opts.statusline[9] = require("astroui.status").component.lsp { lsp_progress = false } end,
    },
  },
}
