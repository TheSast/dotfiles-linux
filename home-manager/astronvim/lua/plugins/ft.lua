---@type LazySpec
return {
  "astrocore",
  ---@type AstroCoreOpts
  opts = {
    filetypes = {
      filename = {
        ["flake.lock"] = "json",
        ["*.crs"] = "rust",
      },
    },
  },
}
