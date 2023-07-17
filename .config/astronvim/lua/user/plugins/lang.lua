return {
  {
    "mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        -- "lua_ls",
      },
    },
  },
  {
    "mason-null-ls.nvim",
    opts = {
      ensure_installed = {
        -- "stylua",
        -- "commitlint",
      },
    },
  },
  {
    "nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "regex",
        "rust",
        "c",
        "cpp",
        "make",
        "bash",
        "fish",
        "markdown",
        "markdown_inline",
        "latex",
        "toml",
        "yaml",
        "http",
        "html",
        "css",
      },
    },
  },
  { "folke/neodev.nvim", opts = {} },
  { "AstroNvim/astrocommunity", version = "*" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.yaml" },
}
