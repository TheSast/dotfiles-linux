vim.api.nvim_create_autocmd("FileType", {
  desc = "Text like documents enable wrap and spell",
  pattern = { "gitcommit", "markdown", "text", "plaintex" },
  group = vim.api.nvim_create_augroup("spell-files", { clear = true }),
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})


-- TODO: add auto dark!
