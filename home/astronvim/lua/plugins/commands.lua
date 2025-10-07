---@type LazySpec
return {
  "astrocore",
  ---@type AstroCoreOpts
  opts = {
    commands = {
      Utf8 = {
        function() vim.cmd.normal { "g8", bang = true } end,
        desc = "Print the hex values of the bytes used in the character under the cursor, assuming it is in UTF-8 encoding. This also shows composing characters.",
      },
    },
  },
}
