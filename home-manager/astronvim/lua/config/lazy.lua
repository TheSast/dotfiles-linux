local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.g.astronvim_first_install = true -- lets AstroNvim know that this is an initial installation
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup {
  spec = {
    -- TODO: dchange `branch="v4"` to `version="^4"` on release
    { "AstroNvim/AstroNvim", branch = "v4", import = "astronvim.plugins" },
    -- pin plugins to known working versions
    -- TODO: Remove branch v4 on release
    { "AstroNvim/astrocommunity", branch = "v4" },
    { import = "plugins" },
  },
  install = { colorscheme = { "astrodark", "habamax" } },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
}
