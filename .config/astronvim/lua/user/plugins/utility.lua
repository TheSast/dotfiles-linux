return {
  { "AstroNvim/astrocommunity", version = "*" },
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.split-and-window.minimap-vim" },
  {
    "minimap.vim",
    event = "User AstroFile",
    init = function()
      vim.g.minimap_width = 10
      vim.g.minimap_block_filetypes = {
        "fugitive",
        "nerdtree",
        "tagbar",
        "fzf",
        "qf",
        "netrw",
        "NvimTree",
        "lazy",
        "mason",
        "prompt",
        "TelescopePrompt",
        "noice",
        "notify",
        "neo-tree",
        "startify",
        "vim-plug",
      }
      vim.g.minimap_highlight_search = 1
      vim.g.minimap_git_colors = 1
    end,
  },
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
  { import = "astrocommunity.split-and-window.edgy-nvim" },
  {
    "edgy.nvim",
    keys = function()
      return {
        {
          "<leader>st",
          function() require("edgy").toggle() end,
          desc = "Toggle Sidebars",
        },
        {
          "<leader>sm",
          function() require("edgy").goto_main() end,
          desc = "Select Main Window",
        },
        {
          "<leader>se",
          "<cmd>Neotree toggle<cr>",
          desc = "Toggle Explorer",
        },
        {
          "<leader>sf",
          function() require("edgy").select() end,
          desc = "Select Sidebar",
        },
        {
          "<leader>e",
          "<nop>",
        },
      }
    end,
    init = function()
      local maps = { n = {} }
      local icon = vim.g.icons_enabled and " " or ""
      maps.n["<leader>s"] = { desc = icon .. "Sidebars" }
      require("astronvim.utils").set_mappings(maps)
    end,
  },
  { import = "astrocommunity.workflow.hardtime-nvim" },
  {
    "hardtime.nvim",
    opts = {
      resetting_keys = {},
      restricted_keys = {
        ["h"] = { "n", "x" },
        ["j"] = { "n", "x" },
        ["k"] = { "n", "x" },
        ["l"] = { "n", "x" },
        ["gj"] = { "n", "x" },
        ["gk"] = { "n", "x" },
      },
      disabled_keys = {
        ["<UP>"] = { "n", "x" },
        ["<DOWN>"] = { "n", "x" },
        ["<LEFT>"] = { "n", "x" },
        ["<RIGHT>"] = { "n", "x" },
        ["<Insert>"] = { "n", "x" },
        ["<Home>"] = { "n", "x" },
        ["<End>"] = { "n", "x" },
        ["<PageUp>"] = { "n", "x" },
        ["<PageDown>"] = { "n", "x" },
      },
    },
  },
}
