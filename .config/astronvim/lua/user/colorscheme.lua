local COLORSCHEME = os.getenv "COLORSCHEME"
if not (COLORSCHEME == nil or COLORSCHEME == "default") then return { COLORSCHEME } end

local schemes = {
  "astrotheme",
  "astrotheme",
  "astrotheme",
  -- 'catppuccin-macchiato',
  "everforest",
  -- 'gruvbox',
  -- 'iceberg',
  -- 'kanagawa',
  -- 'nord',
  "oxocarbon",
  -- 'rose-pine',
  -- 'tokyonight',
  "vscode",
  "nvimgelion",
}
math.randomseed(os.time())
return { schemes[math.random(#schemes)] }
