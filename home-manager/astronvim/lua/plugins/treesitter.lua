return {
  "nvim-treesitter",
  opts = function(_, opts)
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "bash",
      "c",
      "cpp",
      "css",
      "fish",
      "lua",
      "nix",
      "rust",
      "toml",
      "vim",
      "vimdoc",
      "yaml",
    })
  end,
}
