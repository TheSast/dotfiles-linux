return {
  opt = {
    spell = false,
    shell = "/bin/bash",
    showcmdloc = "statusline",
    title = true,
    titlestring = "NeoVim",
    guifont = "FiraCode_NF,JetBrainsMono_NF",
    winblend = 30,
    pumblend = 30,

    --   breakindent = true, -- Wrap indent to match  line start
    --   clipboard = "unnamedplus", -- Connection to the system clipboard
    --   cmdheight = 0, -- hide command line unless needed
    --   completeopt = { "menu", "menuone", "noselect" }, -- Options for insert mode completion
    --   copyindent = true, -- Copy the previous indentation on autoindenting
    --   cursorline = true, -- Highlight the text line of the cursor
    --   expandtab = true, -- Enable the use of space in tab
    --   fileencoding = "utf-8", -- File content encoding for the buffer
    --   fillchars = { eob = " " }, -- Disable `~` on nonexistent lines
    --   foldenable = true, -- enable fold for nvim-ufo
    --   foldlevel = 99, -- set high foldlevel for nvim-ufo
    --   foldlevelstart = 99, -- start with all code unfolded
    --   foldcolumn = vim.fn.has "nvim-0.9" == 1 and "1" or nil, -- show foldcolumn in nvim 0.9
    --   history = 100, -- Number of commands to remember in a history table
    --   ignorecase = true, -- Case insensitive searching
    --   infercase = true, -- Infer cases in keyword completion
    --   laststatus = 3, -- globalstatus
    --   linebreak = true, -- Wrap lines at 'breakat'
    --   mouse = "a", -- Enable mouse support
    --   number = true, -- Show numberline
    --   preserveindent = true, -- Preserve indent structure as much as possible
    --   pumheight = 10, -- Height of the pop up menu
    --   relativenumber = true, -- Show relative numberline
    --   scrolloff = 8, -- Number of lines to keep above and below the cursor
    --   shiftwidth = 2, -- Number of space inserted for indentation
    --   showmode = false, -- Disable showing modes in command line
    --   showtabline = 2, -- always display tabline
    --   sidescrolloff = 8, -- Number of columns to keep at the sides of the cursor
    signcolumn = "auto:1-3",
    --   smartcase = true, -- Case sensitivie searching
    --   smartindent = true, -- Smarter autoindentation
    --   splitbelow = true, -- Splitting a new window below the current one
    --   splitright = true, -- Splitting a new window at the right of the current one
    --   tabstop = 2, -- Number of space in a tab
    --   termguicolors = true, -- Enable 24-bit RGB color in the TUI
    --   timeoutlen = 500, -- Shorten key timeout length a little bit for which-key
    --   undofile = true, -- Enable persistent undo
    --   updatetime = 300, -- Length of time to wait before triggering the plugin
    --   virtualedit = "block", -- allow going past end of line in visual block mode
    --   wrap = false, -- Disable wrapping of lines longer than the width of window
    --   writebackup = false, -- Disable making a backup before overwriting a file
  },
  o = {},
  g = {
    neovide_floating_blur_amount_x = 2.0,
    neovide_floating_blur_amount_y = 2.0,
    neovide_transparency = 0.9,
    neovide_scroll_animation_length = 0.55,
    neovide_hide_mouse_when_typing = true,
    neovide_underline_automatic_scaling = true,
    neovide_padding_top = 0,
    neovide_padding_bottom = 0,
    neovide_padding_right = 0,
    neovide_padding_left = 0,
    neovide_refresh_rate = 120,
    neovide_refresh_rate_idle = 5,
    neovide_no_idle = false,
    neovide_cursor_animation_length = 0.13,
    neovide_cursor_antialiasing = true,
    neovide_cursor_animate_in_insert_mode = true,
    neovide_cursor_animate_animate_command_line = false,
    neovide_cursor_unfocused_outline_width = 0.125,
    neovide_cursor_vfx_mode = "",
    --   highlighturl_enabled = true, -- highlight URLs by default
    --   mapleader = " ", -- set leader key
    --   autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    --   codelens_enabled = true, -- enable or disable automatic codelens refreshing for lsp that support it
    --   lsp_handlers_enabled = true, -- enable or disable default vim.lsp.handlers (hover and signatureHelp)
    --   cmp_enabled = true, -- enable completion at start
    --   autopairs_enabled = true, -- enable autopairs at start
    --   diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    --   icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available)
    --   ui_notifications_enabled = true, -- disable notifications when toggling UI elements
  },
}
