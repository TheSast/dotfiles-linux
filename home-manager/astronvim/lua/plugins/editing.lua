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
