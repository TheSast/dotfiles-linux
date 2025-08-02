---@type LazySpec
return {
  {
    "astrolsp",
    ---@type AstroLSPOpts
    opts = {
      config = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                loadOutDirsFromCheck = true,
                features = "all",
              },
              checkOnSave = true,
              check = {
                command = "clippy",
              },
              procMacro = {
                enable = true,
              },
              inlayHints = {
                locationLinks = { enable = true },
                bindingModeHints = { enable = true },
                closureCaptureHints = { enable = true },
                closureReturnTypeHints = { alwyas = true },
                discriminatingHints = { enable = true },
                expressionAdjustmentHints = { always = true },
                closureReturnTypeHints = { enable = "always" },
              },
            },
          },
        },
      },
    },
  },
  {
    "Saecki/crates.nvim",
    init = function()
      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
        desc = "Load crates.nvim into Cargo buffers",
        pattern = "Cargo.toml",
        callback = function()
          require("cmp").setup.buffer { sources = { { name = "crates" } } }
          require "crates"
        end,
      })
    end,
    opts = {
      src = {
        cmp = { enabled = true },
      },
      null_ls = {
        enabled = true,
        name = "crates.nvim",
      },
    },
  },
}
