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
    "vxpm/ferris.nvim",
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lazy_ferris", { clear = true }),
        desc = "Lazy load Ferris",
        once = true,
        callback = function(args)
          if vim.lsp.get_client_by_id(args.data.client_id).name == "rust_analyzer" then
            if require("ferris.private.config").opts.create_commands then
              require("ferris").create_commands(args.buf)
            end
          end
        end,
      })
    end,
    opts = {
      url_handler = function(str) require("astrocore").system_open(str) end,
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
