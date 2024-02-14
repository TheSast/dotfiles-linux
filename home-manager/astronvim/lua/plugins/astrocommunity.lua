-- reminder that files imported by lazy.nvim are processed in alphabetical order
-- default mappings from astrocommunity will be negated here for a cleaner config
return {
  -- core
  -- { import = "astrocommunity.recipes.heirline-mode-text-statusline" },
  -- motion
  {
    { import = "astrocommunity.motion.nvim-spider" },
    {
      "astrocore",
      opts = {
        mappings = {
          n = {
            ["w"] = false,
            ["e"] = false,
            ["b"] = false,
            ["ge"] = false,
          },
          x = {
            ["w"] = false,
            ["e"] = false,
            ["b"] = false,
            ["ge"] = false,
          },
          o = {
            ["w"] = false,
            ["e"] = false,
            ["b"] = false,
            ["ge"] = false,
          },
        },
      },
    },
  },
  {
    { import = "astrocommunity.motion.leap-nvim" },
    {
      "astrocore",
      opts = {
        mappings = {
          n = {
            ["s"] = false,
            ["S"] = false,
            ["gs"] = false,
          },
          x = {
            ["s"] = false,
            ["S"] = false,
            ["x"] = false,
            ["X"] = false,
            ["gs"] = false,
          },
          o = {
            ["s"] = false,
            ["S"] = false,
            ["x"] = false,
            ["X"] = false,
            ["gs"] = false,
          },
        },
      },
    },
  },
  { import = "astrocommunity.motion.mini-surround" }, -- don't know how to handle manually
  -- lsp?/editing?
  { import = "astrocommunity.lsp.inc-rename-nvim" },
  { import = "astrocommunity.lsp.lsp-inlayhints-nvim" },
  { import = "astrocommunity.lsp.garbage-day-nvim" },
  -- { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
  -- { import = "astrocommunity.diagnostics.trouble-nvim" },
  -- editing
  -- { import = "astrocommunity.fuzzy-finder.telescope-zoxide" },
  -- { import = "astrocommunity.editing-support.telescope-undo-nvim" }, -- WARN: DO NOT UNCOMMET, IS BROKEN, WILL CRIPPLE EDITOR
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.editing-support.zen-mode-nvim" },
  -- utility
  { import = "astrocommunity.utility.noice-nvim" },
}
