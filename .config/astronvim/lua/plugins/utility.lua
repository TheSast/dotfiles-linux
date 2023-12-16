return {
  { import = "astrocommunity.utility.noice-nvim" },
  {
    "noice.nvim",
    enabled = false,
    opts = {
      lsp = {
        -- it keeps sending anotification when saving, yanking, deleting, undoing, it's actually driving me insane
        cmdline = {
          enabled = true,
        },
        message = {
          enabled = false,
        },
        messages = {
          enabled = false,
        },
        popupmenu = {
          enabled = false,
        },
        redirect = {
          enabled = false,
        },
        notify = {
          enabled = false,
        },
        hover = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
      },
    },
  },
}
