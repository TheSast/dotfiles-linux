---Mutate an options table by filter the list-like table of lspconfig sources by available binaries, accounting for cmd overrides
---
--- NOTE: This mutates opts!
---@param opts table # Options table with `servers.when_available` table of sources to filter
---@return table avail # The options table with a filtered source list
local function handle_lspconfig_avail(opts)
  local executable = 1
  opts = opts or {}
  local srcs = opts.servers.when_available or {}
  for i = #srcs, 1, -1 do
    local src = srcs[i]
    if
      vim.fn.executable(
        vim.tbl_get(opts, "config", src, "cmd", 1) or require("lspconfig")[src].document_config.default_config.cmd[1]
      ) ~= executable
    then
      table.remove(srcs, i)
    end
  end
  opts.servers = vim.list_extend(opts.servers.always, srcs)
  return opts
end

---Mutate a config table by enabling partial overriding of cmd in source configuration, defaulting to full override
---
--- NOTE: This mutates config!
---@param config table # The configs table with `cmd.override = "partial"` where partial overriding is desired
---@return table over # The configs table, with each source having a correctly overriden cmd
local function handle_partial_cmd_over(config)
  for src_name, src_config in pairs(config) do
    local default_cmd = require("lspconfig")[src_name].document_config.default_config.cmd
    src_config.cmd = src_config.cmd or default_cmd
    if
      (function()
        local x = src_config.cmd.override
        src_config.cmd.override = nil
        return x
      end)() == "partial"
    then
      for i, _ in ipairs(default_cmd) do
        if
          not (type(src_config.cmd[i]) == "string" or (type(src_config.cmd[i]) == "boolean" and not src_config.cmd[i]))
        then
          src_config.cmd[i] = default_cmd[i]
        end
      end
      for i = #src_config.cmd, 1, -1 do
        if type(src_config.cmd[i]) == "boolean" and not src_config.cmd[i] then table.remove(src_config.cmd, i) end
      end
    end
  end
  return config
end

---@type LazySpec
return {
  {
    "astrolsp",
    opts = handle_lspconfig_avail {
      -- :h lspconfig-server-configurations
      servers = {
        when_available = {
          "bashls",
          "clangd",
          "jdtls",
          "rust_analyzer", -- only seems to properly load in once InsertLeave is sent, and takes a while for `vim.lsp.buf.hover()` to work
          "marksman",
          "html",
          "htmx",
          -- TODO: check setup doc
          "cssls",
          -- TODO: check setup doc
          "jsonls",
          -- TODO: check setup doc
          "yamlls",
          "taplo",
          "awk_ls",
        },
        always = {
          "lua_ls",
          "nil_ls",
        },
      },
      formatting = {
        disabled = {
          "lua_ls",
        },
      },
      diagnostics = {
        virtual_text = true,
        underline = true,
      },
      config = handle_partial_cmd_over {
        cssls = {
          cmd = { override = "partial", "css-languageserver" },
        },
        jsonls = {
          cmd = { override = "partial", "vscode-json-languageserver" },
        },
        jdtls = {
          cmd = { override = "partial", "jdt-language-server" },
        },
        clangd = {
          capabilities = {
            offsetEncoding = "utf-8",
          },
        },
      },
      mappings = {
        n = {
          ["K"] = false,
          ["gh"] = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
        },
      },
    },
  },
  { import = "plugins.lsp" },
  -- TODO: consider https://github.com/udayvir-singh/tangerine.nvim
  -- TODO: consider https://github.com/Olical/nfnl
  -- TODO: consider https://github.com/Olical/aniseed
  -- TODO: consider https://github.com/Olical/conjure
  -- TODO: consider https://github.com/adigitoleo/overview.nvim
  -- TODO: consider https://github.com/jmbuhr/otter.nvim
}
