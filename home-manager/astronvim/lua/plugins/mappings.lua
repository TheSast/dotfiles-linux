return {
  "astrocore",
  opts = {
    mappings = {
      n = {
        ["<leader>bn"] = { "<cmd>enew<CR>", desc = "New File" },
        -- ["<leader>c"] = {
        --   function()
        --     require("astrocore.buffer").close(0)
        --     local bufs = vim.fn.getbufinfo { buflisted = true }
        --     if require("astrocore").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
        --   end,
        --   desc = "Close buffer",
        -- },
        -- the function leaves behind the highlight from indent_blankline for some reason
        ["<leader>gg"] = "<nop>",
        ["<leader>n"] = { "<cmd>tabnew<CR>", desc = "New tab" },
        -- ["<leader>o"] = false,
        ["<leader>o"] = "<nop>",
        ["<C-s>"] = false,
        ["<BS>"] = "<nop>",
        ["<C-a>"] = "<nop>",
        ["<C-r>"] = "<nop>",
        ["<C-q>"] = "<nop>",
        ["<C-x>"] = "<nop>",
        ["<C-z>"] = "<nop>",
        ["<C-Tab>"] = "<nop>",
        ["<Space>"] = "<nop>",
        ["+"] = { "<C-a>", desc = "Increment" },
        ["-"] = { "<C-x>", desc = "Decrement" },
        ["A"] = { "g_a", desc = "Append to line (non-blank)" }, -- broken with <C-o> in insert mode and broken counts
        ["C"] = { '"_c', desc = "Change without yanking" },
        ["D"] = { '"_d', desc = "Delete without yanking" },
        ["H"] = "<nop>",
        ["J"] = {
          function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Next buffer",
        },
        ["K"] = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Previous buffer",
        },
        ["L"] = "<nop>",
        -- ["M"] = { "J", desc = "Merge lines (down)" },
        ["S"] = "<nop>", -- leap refueses to bind to keys mapped to <nop> until another leap mappings is called
        ["U"] = { "<C-r>", desc = "Redo" },
        ["X"] = { "gE", desc = "Previous end of WORD" },
        ["Y"] = "<nop>",
        ["ZZ"] = "<nop>",
        ["ZQ"] = "<nop>",
        ["^"] = { "_", desc = "Start of line (non-blank)" },
        ["_"] = { "g_", desc = "End of line (non-blank)" },
        ["g+"] = "<nop>",
        ["g-"] = "<nop>",
        -- ["g^"] = { "??", desc = "Start of visual line (non-blank)" }, -- TODO: impement proper g^ and equivalent g_ , might not be needed
        -- ["g_"] = { "??", desc = "End of visual line (non-blank)" }, -- TODO: impement proper gg_ and equivalent g_
        ["g_"] = "<nop>",
        ["gA"] = { "A", desc = "Append to line" },
        ["gJ"] = "<nop>",
        -- ["gM"] = { "gJ", desc = "Merge lines (down) without spaces" },
        -- ["gC"] = { "gM", desc = "Go to character at middle of the textline" },
        ["gh"] = { "K", desc = "Go to manual entry" },
        -- ["gc"] = { "gm", desc = "Go to character at middle of the screenline" },
        ["s"] = "<nop>", -- leap refueses to bind to keys mapped to <nop> until another leap mappings is called
        ["x"] = { "ge", desc = "Previous end of word" },
        -- ["zJ"] = { "zt", desc = "Bottom this line" },
        -- ["zK"] = { "zb", desc = "Top this line" },
        -- ["zb"] = "<nop>",
        -- ["zt"] = "<nop>",
      },
      x = {
        ["<C-a>"] = "<nop>",
        ["<C-q>"] = "<nop>",
        ["<C-x>"] = "<nop>",
        ["<C-z>"] = "<nop>",
        ["^"] = { "_", desc = "Start of line (non-blank)" },
        ["_"] = { "g_", desc = "End of line (non-blank)" },
        ["+"] = { "<C-a>", desc = "Increment" },
        ["-"] = { "<C-x>", desc = "Decrement" },
        ["C"] = { '"_c', desc = "Change without yanking" },
        ["D"] = { '"_d', desc = "Delete without yanking" },
        ["H"] = "<nop>",
        ["J"] = "<nop>",
        ["K"] = "<nop>",
        ["L"] = "<nop>",
        -- ["M"] = { "J", desc = "Merge lines (down)" },
        ["X"] = { "gE", desc = "Previous end of WORD" },
        ["Y"] = "<nop>",
        -- ["g^"] = { "??", desc = "Start of visual line (non-blank)" }, -- TODO: impement proper g^ and equivalent g_ , might not be needed
        -- ["g_"] = { "??", desc = "End of visual line (non-blank)" }, -- TODO: impement proper gg_ and equivalent g_
        ["g+"] = { "g<C-a>", desc = "Increment sequentially" },
        ["g-"] = { "g<C-x>", desc = "Decrement sequentially" },
        ["g_"] = "<nop>",
        ["g/"] = { "<esc>/\\%V", desc = "Search inside visual selection" },
        ["g?"] = { "<esc>?\\%V", desc = "Backwards search inside visual selection" },
        ["gE"] = "<nop>",
        ["ge"] = "<nop>",
        ["x"] = { "ge", desc = "Previous end of word" },
      },
      o = {
        -- ["^"] = { "_", desc = "Start of line (non-blank)" },
        ["_"] = { "g_", desc = "End of line (non-blank)" },
        ["+"] = "<nop>",
        ["-"] = "<nop>",
        ["H"] = "<nop>",
        ["J"] = "<nop>",
        ["K"] = "<nop>",
        ["L"] = "<nop>",
        -- ["g^"] = { "??", desc = "Start of visual line (non-blank)" }, -- TODO: impement proper g^ and equivalent g_ , might not be needed
        -- ["g_"] = { "??", desc = "End of visual line (non-blank)" }, -- TODO: impement proper gg_ and equivalent g_
        ["g_"] = "<nop>",
      },
      i = {
        ["<C-BS>"] = "<C-w>",
        ["<C-Del>"] = "<C-Right><C-w>",
        ["<C-a>"] = "<Home>",
        ["<C-e>"] = "<End>",
        ["<C-b>"] = "<Left>",
        ["<C-f>"] = "<Right>",
      },
      c = {
        ["<C-BS>"] = "<C-w>",
        ["<C-Del>"] = "<C-Right><C-w>",
        ["<C-a>"] = "<Home>",
        -- ["<C-e>"] = "<End>", -- present by default
        ["<C-b>"] = "<Left>",
        ["<C-f>"] = "<Right>",
      },
    },
  },
}
