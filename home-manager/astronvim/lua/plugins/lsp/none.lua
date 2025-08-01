--- Filter a list-like table of null-ls sources by available binaries
---
--- NOTE: This mutates srcs!
---@param srcs table # Table of sources to filter
---@return table avail # The filtered list
local function handle_nls_avail(srcs)
  local executable = 1
  srcs = srcs or {}
  for i = #srcs, 1, -1 do
    if vim.fn.executable(srcs[i]._opts.command) ~= executable then table.remove(srcs, i) end
  end
  return srcs
end

---@type LazySpec
return {
  "none-ls.nvim",
  opts = function(_, opts)
    local builtins = require("null-ls").builtins
    -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
    opts.sources = require("astrocore").extend_tbl(
      opts.sources,
      vim.list_extend(
        handle_nls_avail {
          builtins.diagnostics.fish,
          builtins.diagnostics.zsh,
          builtins.diagnostics.alex,
          builtins.diagnostics.stylelint,
          builtins.diagnostics.markdownlint,

          builtins.formatting.cmake_format,
          builtins.formatting.leptosfmt,
          builtins.formatting.nixfmt,
          builtins.formatting.yamlfix,
          builtins.formatting.yamlfmt,
          builtins.formatting.shellharden,
          builtins.formatting.shfmt,
          builtins.formatting.fish_indent,
          builtins.formatting.cbfmt,
          builtins.formatting.prettierd,
        },
        {
          builtins.diagnostics.deadnix,
          builtins.diagnostics.statix,
          builtins.diagnostics.selene,
          -- builtins.diagnostics.commitlint, -- NOTE: broken?
          builtins.formatting.alejandra.with {
            condition = function(_)
              local executable = 1
              return vim.fn.executable(builtins.formatting.nixfmt._opts.command) ~= executable
            end,
          },
          builtins.formatting.stylua,
          -- nls.hover.printenv,
          -- nls.hover.dictionary,
        }
      )
    )
  end,
}
