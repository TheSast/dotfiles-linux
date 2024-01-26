return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls").builtins
    -- does the list fed to null-ls need contain unique elements?
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    local optional_ls = {
      -- nls.diagnostics.ccpcheck,
      -- nls.diagnostics.ccplint,
      nls.diagnostics.clang_check,
      nls.diagnostics.fish,
      nls.diagnostics.zsh,
      nls.diagnostics.shellcheck,
      nls.diagnostics.alex,
      nls.diagnostics.markdownlint,
      nls.diagnostics.mdl,

      nls.formatting.clang_format,
      -- nls.formatting.cmake_format,
      nls.formatting.rustfmt,
      nls.formatting.leptosfmt,
      -- nls.formatting.nixfmt,
      -- nls.formatting.nixpkgs_fmt,
      nls.formatting.taplo,
      nls.formatting.yamlfix,
      nls.formatting.yamlfmt,
      nls.formatting.beautysh,
      nls.formatting.shellharden,
      nls.formatting.shfmt,
      nls.formatting.fish_indent,
      nls.formatting.cbfmt,
      -- nls.formatting.markdownlint,
      -- nls.formatting.prettier,
      nls.formatting.prettierd,
      -- nls.formatting.remark,
      nls.formatting.mdformat,
    }
    local permanent_ls = vim.list_extend(opts.servers or {}, {
      nls.diagnostics.deadnix,
      nls.diagnostics.statix,
      nls.diagnostics.luacheck,
      -- nls.diagnostics.selene,
      nls.diagnostics.commitlint,
      nls.formatting.alejandra,
      nls.formatting.stylua,
      -- nls.formatting.lua_format,
      -- nls.hover.printenv,
      -- nls.hover.dictionary,
    })
    for i = #optional_ls, 1, -1 do
      if vim.fn.executable(optional_ls[i]._opts.command) ~= 1 then table.remove(optional_ls, i) end
    end
    opts.sources = vim.list_extend(permanent_ls, optional_ls)
  end,
}
