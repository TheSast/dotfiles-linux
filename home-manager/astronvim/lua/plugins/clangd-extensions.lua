return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      config = {
        clangd = {
          capabilities = {
            offsetEncoding = "utf-8",
          },
        },
      },
    },
  },
  {
    "p00f/clangd_extensions.nvim", -- install lsp plugin
    lazy = true,
    init = function()
      -- load clangd extensions when clangd attaches
      local augroup =
        vim.api.nvim_create_augroup("clangd_extensions", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = augroup,
        desc = "Load clangd_extensions with clangd",
        callback = function(args)
          if
            assert(vim.lsp.get_client_by_id(args.data.client_id)).name
            == "clangd"
          then
            require("clangd_extensions")
            -- add more `clangd` setup here as needed such as loading autocmds
            vim.api.nvim_del_augroup_by_id(augroup) -- delete auto command since it only needs to happen once
          end
        end,
      })
    end,
  },
}
