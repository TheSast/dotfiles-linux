return {
  "none-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls").builtins
    -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
    local optional_ls = {
      nls.diagnostics.fish,
      nls.diagnostics.zsh,
      nls.diagnostics.alex,
      nls.diagnostics.stylelint,
      nls.diagnostics.markdownlint,

      nls.formatting.cmake_format,
      nls.formatting.leptosfmt,
      nls.formatting.nixfmt,
      nls.formatting.yamlfix,
      nls.formatting.yamlfmt,
      nls.formatting.shellharden,
      nls.formatting.shfmt,
      nls.formatting.fish_indent,
      nls.formatting.cbfmt,
      nls.formatting.prettierd,
    }
    local permanent_ls = vim.list_extend(opts.servers or {}, {
      nls.diagnostics.deadnix,
      nls.diagnostics.statix,
      nls.diagnostics.selene,
      nls.diagnostics.commitlint,
      nls.formatting.alejandra.with {
        condition = function(_)
          local executable = 1
          return vim.fn.executable(nls.formatting.nixfmt._opts.command) ~= executable
        end,
      },
      nls.formatting.stylua,
      -- nls.hover.printenv,
      -- nls.hover.dictionary,
    })
    for i = #optional_ls, 1, -1 do
      if vim.fn.executable(optional_ls[i]._opts.command) ~= 1 then table.remove(optional_ls, i) end
    end
    opts.sources = vim.list_extend(permanent_ls, optional_ls)
  end,
}
