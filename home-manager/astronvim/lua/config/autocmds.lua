-- vim.api.nvim_create_autocmd("VimResized", {
--   desc = "Automatically resize windows when the host window size changes.",
--   pattern = "*",
--   group = vim.api.nvim_create_augroup("vim-resized", { clear = true }),
--   command = "wincmd =",
-- })

vim.api.nvim_create_autocmd("VimLeave", {
  desc = "Auto stop auto-compiler if its running",
  pattern = "*",
  group = vim.api.nvim_create_augroup("vim-leave", { clear = true }),
  callback = function() vim.fn.jobstart { "vim-leave", vim.fn.expand "%:p", "stop" } end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Text like documents enable wrap and spell",
  pattern = { "gitcommit", "markdown", "text", "plaintex" },
  group = vim.api.nvim_create_augroup("spell-files", { clear = true }),
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- vim.api.nvim_create_autocmd("User", {
--   desc = "Auto hide tabline when only a single buffer is present",
--   pattern = "AstroBufsUpdated",
--   group = vim.api.nvim_create_augroup("bufs-updated", { clear = true }),
--   callback = function()
--     local new_showtabline = #vim.t.bufs > 1 and 2 or 1
--     if new_showtabline ~= vim.opt.showtabline:get() then vim.opt.showtabline = new_showtabline end
--   end,
-- })
