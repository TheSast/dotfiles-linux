local TMUX = (os.getenv("TMUX") ~= nil)
local ZELLIJ = (os.getenv("ZELLIJ") ~= nil)
if not TMUX and not ZELLIJ then
	return {
		plugins = {},
		icons = function(v)
			return v
		end,
	}
end

local icons = {
	BufferClose = "✗",
	DapStopped = "",
	DefaultFile = "",
	Diagnostic = "",
	DiagnosticError = "",
	DiagnosticHint = "",
	DiagnosticInfo = "",
	Git = "",
	LSPLoading2 = "",
	Paste = "",
	Spellcheck = "",
	Search = "",
	TabClose = "",
	Package = "",
	Sort = "",
	Session = "",
	Tab = "",
	WordFile = "",
}

local function get_icon(kind)
	return icons[kind]
end

return {
	-- Inside your user/plugins/utf8mux.lua:
	-- ```
	-- return require("user.utf8mux").icons`
	-- ```
	plugins = {
		{
			"lspkind.nvim",
			optional = true,
			opts = function(_, opts)
				if opts.preset ~= "codicons" then
					opts.symbol_map = {
						Array = "",
						Key = "",
						Namespace = "",
						Null = "",
						Object = "",
						Package = "",
						String = "",
						TypeParameter = "",
						Text = "",
						Method = "",
						Function = "",
						Field = "",
						Variable = "",
						Class = "",
						Value = "",
						Keyword = "",
						Color = "",
						File = get_icon("DefaultFile"),
						Folder = "",
						Constant = "",
						Struct = "",
						Operator = "",
					}
				end
			end,
		},
		{
			"nvim-web-devicons",
			optional = true,
			opts = {
				override = {
					lock = {
						icon = "",
					},
					mp3 = {
						icon = "",
					},
					-- ["robots.txt"] = {
					-- icon = "󰚩"
					-- }, -- found no alternative
					cs = {
						icon = "",
					},
					csv = {
						icon = get_icon("DefaultFile"),
					},
					doc = {
						icon = "",
					},
					docx = {
						icon = "",
					},
					-- f90 = {
					--   icon = "󱈚", -- found no alternative
					-- },
					material = {
						icon = "",
					},
					mint = {
						icon = "",
					},
					opus = {
						icon = "",
					},
					ppt = {
						icon = "",
					},
					ps1 = {
						icon = "",
					},
					psd1 = {
						icon = "",
					},
					psm1 = {
						icon = "",
					},
					r = {
						icon = "",
					},
					-- rproj = {
					--   icon = "󰗆", -- found no alternative
					-- },
					-- scm = {
					--   icon = "󰘧", -- found no alternative
					-- },
					sv = {
						icon = "",
					},
					svh = {
						icon = "",
					},
					svg = {
						icon = "",
					},
					-- tbc = {
					--   icon = "󰛓", -- found no alternative
					-- },
					-- tcl = {
					--   icon = "󰛓",
					-- },
					tex = {
						icon = "",
					},
					tscn = {
						icon = "",
					},
					txt = {
						icon = get_icon("DefaultFile"),
					},
					v = {
						icon = "",
					},
					vh = {
						icon = "",
					},
					vhd = {
						icon = "",
					},
					vhdl = {
						icon = "",
					},
					webpack = {
						icon = "",
					},
					xls = {
						icon = "",
					},
					xlsx = {
						icon = "",
					},
					xml = {
						icon = "",
					},
					sol = {
						icon = "",
					},
					prisma = {
						icon = "",
					},
					-- log = {
					--   icon = "󰌱", -- found no good alternative
					-- },
				},
			},
		},
	},

	-- Inside your user/icons.lua:
	-- ```
	-- return require("user.utf8mux").icons {
	--   YOUR_ICONS
	-- }
	-- ```
	icons = function(user_icons)
		for key, value in pairs(icons) do
			user_icons[key] = value
		end
		return user_icons
	end,
}
