return {
  { "AstroNvim/astrocommunity", version = "*" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.lsp.inc-rename-nvim" },
  { import = "astrocommunity.lsp.lsp-inlayhints-nvim" },
  { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.editing-support.zen-mode-nvim" },
  {
    "zen-mode.nvim",
    keys = {
      {
        "<leader>z",
        "<cmd>ZenMode<CR>",
        desc = "Enter Zen Mode",
      },
    },
  },
  { import = "astrocommunity.editing-support.dial-nvim" },
  {
    "dial.nvim",
    keys = function()
      return {
        {
          "+",
          mode = { "v" },
          function() return require("dial.map").inc_visual() end,
          expr = true,
          desc = "Increment",
        },
        {
          "-",
          mode = { "v" },
          function() return require("dial.map").dec_visual() end,
          expr = true,
          desc = "Decrement",
        },
        {
          "g+",
          mode = { "v" },
          function() return require("dial.map").inc_gvisual() end,
          expr = true,
          desc = "Increment",
        },
        {
          "g-",
          mode = { "v" },
          function() return require("dial.map").dec_gvisual() end,
          expr = true,
          desc = "Decrement",
        },
        {
          "+",
          function() return require("dial.map").inc_normal() end,
          expr = true,
          desc = "Increment",
        },
        {
          "-",
          function() return require("dial.map").dec_normal() end,
          expr = true,
          desc = "Decrement",
        },
      }
    end,
  },
}
