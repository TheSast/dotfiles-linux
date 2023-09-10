return {
  n = {
    ["<leader>bn"] = { "<cmd>enew<CR>", desc = "New File" },
    ["<leader>c"] = {
      function()
        require("astronvim.utils.buffer").close(0)
        local bufs = vim.fn.getbufinfo { buflisted = true }
        if require("astronvim.utils").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
      end,
      desc = "Close buffer",
    },
    ["<leader>gg"] = "<nop>",
    ["<leader>lk"] = { "K", desc = "Go to manual entry" },
    ["<leader>n"] = { "<cmd>tabnew<CR>", desc = "New tab" },
    ["<leader>o"] = false,
    ["<C-s>"] = false,
    ["<BS>"] = "<nop>",
    ["<C-a>"] = "<nop>",
    ["<C-q>"] = "<nop>",
    ["<C-x>"] = "<nop>",
    ["<C-z>"] = "<nop>",
    ["<C-Tab>"] = "<nop>",
    ["<Space>"] = "<nop>",
    ["+"] = { "<C-a>", desc = "Increment" },
    ["-"] = { "<C-x>", desc = "Decrement" },
    ["A"] = { "g_a", desc = "Append to line (non-blank)" },
    ["C"] = { '"_c', desc = "Change without yanking" },
    ["D"] = { '"_d', desc = "Delete without yanking" },
    ["H"] = "<nop>",
    ["J"] = "<nop>",
    ["K"] = "<nop>",
    ["L"] = "<nop>",
    ["M"] = { "J", desc = "Merge lines (down)" },
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
    ["gM"] = { "gJ", desc = "Merge lines (down) without spaces" },
    ["gC"] = { "gM", desc = "Go to character at middle of the textline" },
    ["gc"] = { "gm", desc = "Go to character at middle of the screenline" },
    ["x"] = { "ge", desc = "Previous end of word" },
    ["zJ"] = { "zt", desc = "Bottom this line" },
    ["zK"] = { "zb", desc = "Top this line" },
    ["zb"] = "<nop>",
    ["zt"] = "<nop>",
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
    ["M"] = { "J", desc = "Merge lines (down)" },
    ["X"] = { "gE", desc = "Previous end of WORD" },
    ["Y"] = "<nop>",
    -- ["g^"] = { "??", desc = "Start of visual line (non-blank)" }, -- TODO: impement proper g^ and equivalent g_ , might not be needed
    -- ["g_"] = { "??", desc = "End of visual line (non-blank)" }, -- TODO: impement proper gg_ and equivalent g_
    ["g_"] = "<nop>",
    ["g/"] = { "<esc>/\\%V", desc = "Search inside visual selection" },
    ["g?"] = { "<esc>?\\%V", desc = "Backwards search inside visual selection" },
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
    ["<C-e>"] = "<End>",
    ["<C-b>"] = "<Left>",
    ["<C-f>"] = "<Right>",
  },
  -- t = {
  -- },
}
-- ["<C-[>"] equivalent to <Esc> in terminal
-- ["<C-_>"] equivalent to C--> in terminal
-- ["<C-@>"] resolves to <C-g> in terminal
-- ["<C-Space>"] equivalent to ["<C-@>"]
-- ["<C-h>"] equivalent to <C-BS> in terminal
-- ["<C-i>"] equivalent to <Tab> in terminal
-- ["<C-j>"] equivalent to <NL> in terminal
-- ["<C-m>"] equivalent to <CR> in terminal
