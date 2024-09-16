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
  -- { import = "astrocommunity.editing-support.dial-nvim" },
  -- utility
  { import = "astrocommunity.utility.noice-nvim" },
  -- TODO: add to austrocommunity
  -- utf8 support to nvim-spider
  -- https://github.com/chikko80/error-lens.nvim
  -- https://github.com/NvChad/nvcommunity/tree/main/lua/nvcommunity/editor/beacon
  -- https://github.com/NvChad/nvcommunity/tree/main/lua/nvcommunity/editor/biscuits
  -- https://github.com/NvChad/nvcommunity/tree/main/lua/nvcommunity/editor/symbols-outline
  -- https://github.com/NvChad/nvcommunity/tree/main/lua/nvcommunity/editor/treesittercontext
  -- https://github.com/NvChad/nvcommunity/tree/main/lua/nvcommunity/editor/undo
  -- https://github.com/NvChad/nvcommunity/tree/main/lua/nvcommunity/editor/fold-cycle
  -- https://github.com/NvChad/nvcommunity/tree/main/lua/nvcommunity/editor/fold-preview
  -- https://github.com/NvChad/nvcommunity/tree/main/lua/nvcommunity/editor/origami
  -- https://github.com/NvChad/nvcommunity/tree/main/lua/nvcommunity/editor/tailwindfold
  -- https://github.com/NvChad/nvcommunity/tree/main/lua/nvcommunity/editor/lazygit
  -- https://github.com/NvChad/nvcommunity/tree/main/lua/nvcommunity/lsp/codeactionmenu
  -- https://github.com/NvChad/nvcommunity/tree/main/lua/nvcommunity/lsp/barbecue
  -- https://github.com/NvChad/nvcommunity/tree/main/lua/nvcommunity/lsp/dim
  -- https://github.com/NvChad/nvcommunity/tree/main/lua/nvcommunity/lsp/lspsaga
  -- https://github.com/NvChad/nvcommunity/tree/main/lua/nvcommunity/lsp/lspui
  -- https://github.com/NvChad/nvcommunity/tree/main/lua/nvcommunity/lsp/prettyhover
  -- https://github.com/NvChad/nvcommunity/tree/main/lua/nvcommunity/motion/bookmarks
  -- https://github.com/NvChad/nvcommunity/tree/main/lua/nvcommunity/tools/conjure
  -- https://github.com/Olical/nfnl
  -- https://github.com/roobert/hoversplit.nvim
  -- https://github.com/lewis6991/hover.nvim
  -- https://github.com/soulis-1256/eagle.nvim
  -- https://github.com/amrbashir/nvim-docs-view
  -- https://github.com/neovim/nvimdev.nvim
  -- https://github.com/nvimdev/epo.nvim
  -- https://github.com/nvimdev/lspsaga.nvim
  -- https://github.com/nvimdev/dashboard-nvim
  -- https://github.com/nvimdev/guard.nvim
  -- https://github.com/nvimdev/hlsearch.nvim
  -- https://github.com/luackasRanarison/nvim-devdocs
  -- https://github.com/3rd/image.nvim
  -- https://github.com/00sap/visual.nvim
}
