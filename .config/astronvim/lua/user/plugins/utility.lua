return {
  -- {
  --   "glacambre/firenvim",
  --   cond = not not vim.g.started_by_firenvim,
  --   build = function()
  --     require("lazy").load { plugins = "firenvim", wait = true }
  --     vim.fn["firenvim#install"](0)
  --   end,
  -- },
  {
    "wfxr/minimap.vim",
    event = "User AstroFile",
    keys = {
      { "<leader>um", "<cmd>MinimapToggle<CR>", desc = "Toggle minimap", mode = { "n" } },
    },
    init = function()
      vim.g.minimap_highlight_search = 1
      vim.g.minimap_git_colors = 1
    end,
  },
  { "AstroNvim/astrocommunity", version = "*" },
  { import = "astrocommunity.utility.noice-nvim" },
  {
    "noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            find = "%d+L,%s%d+B",
          },
          opts = { skip = true },
        },
      },
    },
  },
  -- { import = "astrocommunity.bars-and-lines.dropbar-nvim" }, -- requires nvim 0.10
  { import = "astrocommunity.workflow.hardtime-nvim" },
}
