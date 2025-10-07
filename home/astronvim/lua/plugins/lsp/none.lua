---@type LazySpec
return {
  "none-ls.nvim",
  opts = function(_, opts)
    local builtins = require("null-ls").builtins
    -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
    opts.sources = vim.list_extend(
      vim.tbl_filter(function(src) return vim.utils.executable(src._opts.command) end, {
        builtins.diagnostics.fish,
        builtins.diagnostics.zsh,
        builtins.diagnostics.alex,
        builtins.diagnostics.stylelint,
        builtins.diagnostics.markdownlint,

        builtins.formatting.cmake_format,
        builtins.formatting.uncrustify,
        builtins.formatting.leptosfmt,
        builtins.formatting.nixfmt,
        builtins.formatting.yamlfix,
        builtins.formatting.yamlfmt,
        builtins.formatting.shellharden,
        builtins.formatting.shfmt, -- FIXME: should be ran by bashls
        builtins.formatting.fish_indent,
        builtins.formatting.mdformat,
        builtins.formatting.cbfmt,
        builtins.formatting.prettierd,
      }),
      {
        builtins.diagnostics.deadnix,
        builtins.diagnostics.statix,
        builtins.diagnostics.selene,
        -- builtins.diagnostics.commitlint, -- NOTE: broken?
        builtins.formatting.alejandra.with {
          condition = function(_) return not vim.utils.executable(builtins.formatting.nixfmt._opts.command) end,
        },
        builtins.formatting.stylua,
        -- nls.hover.printenv,
        -- nls.hover.dictionary,
      }
    )
  end,
}
