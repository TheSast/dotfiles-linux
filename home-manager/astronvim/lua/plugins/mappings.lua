-- this mappings file is supposed to be usable regardless of the presence of additional plugins
---@type LazySpec
return {
  {
    "astrocore",
    ---@type AstroCoreOpts
    opts = {
      -- ISSUE: mappings set to "<NOP>" still have their `desc`
      mappings = {
        n = {
          ["<Leader>bn"] = { "<Cmd>enew<CR>", desc = "New File" },
          -- ["<Leader>c"] = {
          --   function()
          --     require("astrocore.buffer").close(0)
          --     local bufs = vim.fn.getbufinfo { buflisted = true }
          --     if require("astrocore").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
          --   end,
          --   desc = "Close buffer",
          -- },
          -- the function leaves behind the highlight from indent_blankline for some reason
          ["<Leader>gg"] = "<NOP>",
          ["<Leader>n"] = { "<Cmd>tabnew<CR>", desc = "New tab" },
          -- ["<Leader>o"] = false,
          ["<Leader>o"] = "<NOP>",
          ["<C-s>"] = false,
          ["<BS>"] = "<NOP>",
          ["<C-a>"] = "<NOP>",
          ["<C-r>"] = "<NOP>",
          ["<C-q>"] = "<NOP>",
          ["<C-x>"] = "<NOP>",
          ["<C-z>"] = "<NOP>",
          ["<C-Tab>"] = "<NOP>",
          ["<Space>"] = "<NOP>",
          ["+"] = { "<C-a>", desc = "Increment" },
          ["-"] = { "<C-x>", desc = "Decrement" },
          ["A"] = { "g_a", desc = "Append to line (non-blank)" }, -- broken with <C-o> in insert mode and broken counts
          ["C"] = { '"_c', desc = "Change without yanking" },
          ["D"] = { '"_d', desc = "Delete without yanking" },
          ["H"] = "<NOP>",
          ["J"] = {
            function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
            desc = "Next buffer",
          },
          ["K"] = {
            function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
            desc = "Previous buffer",
          },
          ["L"] = "<NOP>",
          -- ["M"] = { "J", desc = "Merge lines (down)" },
          ["S"] = "<NOP>", -- leap refueses to bind to keys mapped to <NOP> until another leap mappings is called
          ["U"] = { "<C-r>", desc = "Redo" },
          ["X"] = { "gE", desc = "Previous end of WORD" },
          ["Y"] = "<NOP>",
          ["ZZ"] = "<NOP>",
          ["ZQ"] = "<NOP>",
          ["^"] = { "_", desc = "Start of line (non-blank)" },
          ["_"] = { "g_", desc = "End of line (non-blank)" },
          ["g+"] = "<NOP>",
          ["g-"] = "<NOP>",
          ["g_"] = "<NOP>",
          ["g^"] = { desc = "Start of visual line (non-blank)" },
          ["gA"] = { "A", desc = "Append to line" },
          ["gJ"] = "<NOP>",
          -- ["g_"] = { "??", desc = "End of visual line (non-blank)" }, -- TODO: impement end on line equivalent to g^
          ["gh"] = { "K", desc = "Go to manual entry" },
          -- ["gc"] = { "gm", desc = "Go to character at middle of the screenline" },
          ["s"] = "<NOP>",
          ["x"] = { "ge", desc = "Previous end of word" },
          -- ["zJ"] = { "zt", desc = "Bottom this line" },
          -- ["zK"] = { "zb", desc = "Top this line" },
          -- ["zb"] = "<NOP>",
          -- ["zt"] = "<NOP>",
        },
        x = {
          ["<C-a>"] = "<NOP>",
          ["<C-q>"] = "<NOP>",
          ["<C-x>"] = "<NOP>",
          ["<C-z>"] = "<NOP>",
          ["^"] = { "_", desc = "Start of line (non-blank)" },
          ["_"] = { "g_", desc = "End of line (non-blank)" },
          ["+"] = { "<C-a>", desc = "Increment" },
          ["-"] = { "<C-x>", desc = "Decrement" },
          ["C"] = { '"_c', desc = "Change without yanking" },
          ["D"] = { '"_d', desc = "Delete without yanking" },
          ["H"] = "<NOP>",
          ["J"] = "<NOP>",
          ["K"] = "<NOP>",
          ["L"] = "<NOP>",
          -- ["M"] = { "J", desc = "Merge lines (down)" },
          ["X"] = { "gE", desc = "Previous end of WORD" },
          ["Y"] = "<NOP>",
          ["g^"] = { desc = "Start of visual line (non-blank)" },
          ["g+"] = { "g<C-a>", desc = "Increment sequentially" },
          ["g-"] = { "g<C-x>", desc = "Decrement sequentially" },
          -- ["g_"] = { "??", desc = "End of visual line (non-blank)" }, -- TODO: impement end on line equivalent to g^
          ["g_"] = "<NOP>",
          ["g/"] = { "<esc>/\\%V", desc = "Search inside visual selection" },
          ["g?"] = { "<esc>?\\%V", desc = "Backwards search inside visual selection" },
          ["gE"] = "<NOP>",
          ["ge"] = "<NOP>",
          ["x"] = { "ge", desc = "Previous end of word" },
          -- TODO: add proper `desc` for `({)}`
        },
        o = {
          ["_"] = { "g_", desc = "End of line (non-blank)" },
          -- ["^"] = { "??", desc = "Start of line (non-blank)" },
          -- ["0"] = { "??", desc = "Start of line" }, -- ISSUE: no counts, no counts repetition
          ["+"] = "<NOP>",
          ["-"] = "<NOP>",
          ["H"] = "<NOP>",
          ["J"] = "<NOP>",
          ["K"] = "<NOP>",
          ["L"] = "<NOP>",
          ["g^"] = { desc = "Start of visual line (non-blank)" },
          -- ["g_"] = { "??", desc = "End of visual line (non-blank)" }, -- TODO: impement end on line equivalent to g^
          ["g_"] = "<NOP>",
          -- TODO: add proper `desc` for `({)}`
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
          ["<C-a>"] = "<Home>",
          -- ["<C-e>"] = "<End>", -- present by default
          ["<C-Del>"] = "<C-Right><C-w>", -- FIXME: not the same as actual <C-Del>
          ["<C-b>"] = "<Left>",
          ["<C-f>"] = "<Right>",
        },
      },
    },
  },
  {
    end,
  },
}
