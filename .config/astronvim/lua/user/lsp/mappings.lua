return function(mappings)
  mappings.n["K"] = false
  mappings.n["<leader>lk"] = {
    function() vim.lsp.buf.hover() end,
    desc = "Hover symbol details",
  }
  return mappings
end
