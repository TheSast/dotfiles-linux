return {
  "AstroNvim/astrolsp",
  ---@param opts AstroLSPOpts
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
      { "cssls", "vscode-css-language-server" }, -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
      { "jsonls", "vscode-json-language-server" }, -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
      { "yamlls", "yaml-language-server" }, -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
      { "awk_ls", "awk-language-server" },
    }
    local permanent_srv = vim.list_extend(opts.servers or {}, {
      "lua_ls",
      "nil_ls",
    })
    opts.formatting = require("astrocore").extend_tbl(opts.config or {}, {
      disabled = {
        -- "rust_analyzer",
        -- "lua_ls",
      },
    })
    opts.diagnostics = require("astrocore").extend_tbl(opts.diagnostics or {}, {
      virtual_text = true,
      underline = true,
    })
    opts.config = require("astrocore").extend_tbl(opts.config or {}, {
      -- rust_analyzer = {
      --   settings = {
      --     ["rust-analyzer"] = {
      --       cargo = {
      --         loadOutDirsFromCheck = true,
      --         features = "all",
      --       },
      --       checkOnSave = true,
      --       check = {
      --         command = "clippy",
      --       },
      --       procMacro = {
      --         enable = true,
      --       },
      --       inlayHints = {
      --         locationLinks = { enable = true },
      --         bindingModeHints = { enable = true },
      --         closureCaptureHints = { enable = true },
      --         closureReturnTypeHints = { alwyas = true },
      --         discriminatingHints = { enable = true },
      --         expressionAdjustmentHints = { always = true },
      --       },
      --     },
      --   },
      -- },
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              global = { "vim" },
            },
          },
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
        optional_srv[i] = optional_srv[i][1]
      else
        is_in_path = vim.fn.executable(optional_srv[i]) == 1
      end
      if not is_in_path then table.remove(optional_srv, i) end
    end
    opts.servers = vim.list_extend(permanent_srv, optional_srv)
  end,
}
