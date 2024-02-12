-- Example customization of Treesitter
return {
  "nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
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
