return {
  "astrolsp",
  opts = function(_, opts)
    -- does the list fed to astrolsp need contain unique elements?
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    local optional_srv = {
      { "bashls", "bash-language-server" },
      "clangd",
      { "rust_analyzer", "rust-analyzer" },
      "marksman",
      { "html", "html-language-server" },
      { "htmx", "htmx-lsp" },
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
      -- { "cssls", "vscode-css-language-server" },
      { "cssls", "css-languageserver" }, -- NixOS seems to have a different binary name
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
      -- { "jsonls", "vscode-json-language-server" },
      { "jsonls", "vscode-json-languageserver" }, -- NixOS seems to have a different binary name
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
      { "yamlls", "yaml-language-server" },
      "taplo",
      { "awk_ls", "awk-language-server" },
    }
    local permanent_srv = vim.list_extend(opts.servers or {}, {
      "lua_ls",
      "nil_ls",
    })
    opts.formatting = require("astrocore").extend_tbl(opts.config or {}, {
      disabled = {
        "lua_ls",
      },
    })
    opts.diagnostics = require("astrocore").extend_tbl(opts.diagnostics or {}, {
      virtual_text = true,
      underline = true,
    })
    opts.config = require("astrocore").extend_tbl(opts.config or {}, {
      -- lua_ls = {
      --   settings = {
      --     Lua = {
      --       diagnostics = {
      --         global = { "vim" },
      --       },
      --     },
      --   },
      -- },
      cssls = {
        cmd = {
          "css-languageserver", -- NixOS seems to have a different binary name
          "--stdio",
        },
      },
      jsonls = {
        cmd = {
          "vscode-json-languageserver", -- NixOS seems to have a different binary name
          "--stdio",
        },
      },
    })
    opts.mappings = require("astrocore").extend_tbl(opts.mappings or {}, {
      n = {
        ["K"] = false,
        ["gh"] = {
          function() vim.lsp.buf.hover() end,
          desc = "Hover symbol details",
        },
      },
    })

    for i = #optional_srv, 1, -1 do
      local is_in_path
      if type(optional_srv[i]) == "table" then
        is_in_path = vim.fn.executable(optional_srv[i][2] or optional_srv[i][1]) == 1
        ---@diagnostic disable-next-line:assign-type-mismatch
        optional_srv[i] = optional_srv[i][1]
      else
        is_in_path = vim.fn.executable(optional_srv[i]) == 1
      end
      if not is_in_path then table.remove(optional_srv, i) end
    end
    opts.servers = vim.list_extend(permanent_srv, optional_srv)
  end,
}
