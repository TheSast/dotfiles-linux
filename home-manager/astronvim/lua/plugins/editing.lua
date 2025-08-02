---@type LazySpec
return {
  {
    "monkoose/matchparen.nvim",
    lazy = false,
    opts = {},
  },
  {
    "zen-mode.nvim",
    dependencies = {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<Leader>z"] = { function() vim.cmd "ZenMode" end, desc = "Enter Zen Mode" },
          },
        },
      },
    },
  },
  {
    "epwalsh/obsidian.nvim",
    enabled = false,
    version = "*",
    event = {
      -- refer to `:h file-pattern` for more examples
      "BufReadPre "
        .. vim.fn.expand "~"
        .. "/Documents/Obsidian/main/*.md",
      "BufEnter " .. vim.fn.expand "~" .. "/Documents/Obsidian/main/*.md",
      "BufNewFile " .. vim.fn.expand "~" .. "/Documents/Obsidian/main/*.md",
    },
    dependencies = {
      "plenary.nvim",
    },
    init = function(_) vim.opt_local.conceallevel = 1 end,
    opts = {
      disable_frontmatter = true,
      workspaces = {
        {
          name = "main",
          path = "~/Documents/Obsidian/main",
        },
      },
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function() return require("obsidian").util.gf_passthrough() end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>oc"] = {
          action = function() return require("obsidian").util.toggle_checkbox() end,
          opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function() return require("obsidian").util.smart_action() end,
          opts = { buffer = true, expr = true },
        },
      },
    },
  },
}
-- TODO: consider nvim-lightbulb
-- TODO: consider vim-radical or more maintained alternatives
-- TODO: consider vim-case-changer or more maintained alternatives
-- TODO: consider https://github.com/iamcco/markdown-preview.nvim (maybe-lang?)
-- TODO: consider neogen
-- TODO: consider undotree
-- TODO: consider https://github.com/luckasRanarison/nvim-devdocs (maybe-lang?)
-- TODO: consider https://github.com/nanotee/zoxide.vim
-- TODO: consider https://github.com/ecthelionvi/NeoComposer.nvim
-- TODO: consider https://github.com/chrisgrieser/nvim-rip-substitute
-- TODO: consider https://github.com/chrisgrieser/ THERE ARE SO MANY
-- e.g.
--https://github.com/chrisgrieser/nvim-scissors
--https://github.com/chrisgrieser/nvim-tinygit
-- TODO: consider https://github.com/gbprod/yanky.nvim
-- TODO: consider https://github.com/MagicDuck/grug-far.nvim
--https://github.com/backdround/improved-search.nvim
--https://github.com/andrep/vimacs
