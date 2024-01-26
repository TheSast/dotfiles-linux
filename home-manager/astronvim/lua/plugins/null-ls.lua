return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"
    -- does the list fed to null-ls need contain unique elements?
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    local optional_ls = {
      -- null_ls.builtins.diagnostics.ccpcheck,
      -- null_ls.builtins.diagnostics.ccplint,
      null_ls.builtins.diagnostics.clang_check,
      null_ls.builtins.diagnostics.fish,
      null_ls.builtins.diagnostics.zsh,
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.diagnostics.alex,
      null_ls.builtins.diagnostics.markdownlint,
      null_ls.builtins.diagnostics.mdl,

      null_ls.builtins.formatting.clang_format,
      -- null_ls.builtins.formatting.cmake_format,
      null_ls.builtins.formatting.rustfmt,
      -- null_ls.builtins.formatting.nixfmt,
      -- null_ls.builtins.formatting.nixpkgs_fmt,
      null_ls.builtins.formatting.taplo,
      null_ls.builtins.formatting.yamlfix,
      null_ls.builtins.formatting.yamlfmt,
      null_ls.builtins.formatting.beautysh,
      null_ls.builtins.formatting.shellharden,
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.formatting.fish_indent,
      null_ls.builtins.formatting.cbfmt,
      -- null_ls.builtins.formatting.markdownlint,
      -- null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.prettierd,
      -- null_ls.builtins.formatting.remark,
      null_ls.builtins.formatting.mdformat,
    }
    local permanent_ls = vim.list_extend(opts.servers or {}, {
      null_ls.builtins.diagnostics.deadnix,
      null_ls.builtins.diagnostics.statix,
      null_ls.builtins.diagnostics.luacheck,
      -- null_ls.builtins.diagnostics.selene,
      null_ls.builtins.diagnostics.commitlint,
      null_ls.builtins.formatting.alejandra,
      null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.lua_format,
      -- null_ls.builtins.hover.printenv,
      -- null_ls.builtins.hover.dictionary,
    })
    for i = #optional_ls, 1, -1 do
      if vim.fn.executable(optional_ls[i]._opts.command) ~= 1 then table.remove(optional_ls, i) end
    end
    opts.sources = vim.list_extend(permanent_ls, optional_ls)
  end,
}
