---@type LazySpec
return {
  {
    "astrocore",
    ---@type AstroCoreOpts
    opts = {
      -- TODO: clean up possible jumplist pollution, see *jump-motions*
      -- ISSUE: inconsistent cursor kidnapping
      -- ISSUE: multiple text-object such as `o_'` `o_"` lack count and multiline seeking support
      -- IDEA: `o_´` text-object
      -- IDEA: , . ; : + - = ~ _ * # / | \ & $ separator text-objects
      -- IDEA: having `n` or `p` modifiers to text-objects and making them only work while covering them with the cursor by default
      mappings = {
        [""] = {
          ["'"] = "`",
          ["H"] = "<NOP>",
          ["L"] = "<NOP>",
          ["M"] = "<NOP>",
          ["X"] = { "gE", desc = "Previous end of WORD" },
          ["^"] = { "_", desc = "Start of text line" },
          ["_"] = { "g_", desc = "End of text line" },
          ["`"] = "<NOP>",
          ["g'"] = "g`",
          ["g<lt>"] = "<NOP>",
          ["gE"] = "<NOP>",
          ["gH"] = "<NOP>",
          ["g`"] = "<NOP>",
          ["g_"] = {
            function()
              vim.cmd.normal { "g$", bang = true }
              local cursor_pos = vim.api.nvim_win_get_cursor(0)
              cursor_pos[1] = cursor_pos[1]
              local is_whitespace = vim.api.nvim_get_current_line():sub(cursor_pos[2] + 1, cursor_pos[2] + 1):match "%s"
              if is_whitespace then
                local x = vim.utils.find_back(vim.api.nvim_get_current_line(), "%S", cursor_pos[2])
                if x then vim.api.nvim_win_set_cursor(0, { cursor_pos[1], x - 1 }) end
              end
            end,
            desc = "End of screen text line",
          },
          ["ge"] = "<NOP>",
          ["gh"] = "<NOP>",
          -- ["<CR>"] = "<NOP>", -- needed for q:
          -- ["<S-CR>"] = "<NOP>",
          -- ["<C-CR>"] = "<NOP>",
          -- ["<C-BS>"] = "<NOP>",
          ["x"] = { "ge", desc = "Previous end of WORD" },
          ["gd"] = "<NOP>",
          ["gD"] = "<NOP>",
        },
        n = {
          -- ISSUE: `:h motion-count-multiplied` operators don't respect the count order,
          -- `3c2wtest<Esc>` should be make `f*o bar baz` -> `fhihih*baz`
          ["<Leader>bf"] = { function() vim.cmd.enew() end, desc = "New File" },
          ["<Leader>bt"] = {
            function()
              for _ = 1, vim.v.count1 do
                vim.cmd.tabnew()
              end
            end,
            desc = "New Tab",
          },
          ["<Leader>bC"] = false,
          ["<Leader>gg"] = false,
          ["<Leader>n"] = false,
          ["<Leader>o"] = false,
          ["<Leader>R"] = false,
          ["<Leader>Q"] = false,
          ["<Leader>/"] = false,
          ["<BS>"] = { "<DEL>", desc = "Delete character or count" },
          ["<C-a>"] = "<NOP>",
          ["<C-c>"] = "<NOP>",
          ["<C-g>"] = "<NOP>", -- TODO: turn {count}<C-g> into an ex command `:ffile`
          ["<C-n>"] = "<NOP>",
          ["<C-p>"] = "<NOP>",
          ["<C-Q>"] = "<NOP>",
          ["<C-r>"] = "<NOP>",
          ["<C-S>"] = false,
          ["<C-W>d"] = false,
          ["<C-W><C-D>"] = false,
          ["<C-x>"] = "<NOP>",
          ["<C-z>"] = "<NOP>",
          ["<S-BS>"] = { '"_<DEL>', desc = "Delete character without yanking" }, -- IDEA: this should also instantly reset counts when given
          ["<C-Tab>"] = "<NOP>",
          ["<S-Tab>"] = "<NOP>",
          ["<Space>"] = "<NOP>",
          ["&"] = "<Cmd>&&<CR>", -- default uses : instead of <Cmd>
          ["+"] = { "<C-a>", desc = "Increment" },
          ["-"] = { "<C-x>", desc = "Decrement" },
          -- ["~"] = { "g~", desc = "Switch case" }, -- just set tildeop
          -- ["g~"] = "<NOP>",
          ["~"] = "<NOP>",
          ["gl"] = false,
          ["gq"] = "<NOP>",
          ["gQ"] = "<NOP>",
          ["ga"] = "<NOP>",
          ["g8"] = "<NOP>",
          ["8g8"] = "<NOP>",
          ["gs"] = "<NOP>",
          ["gw"] = "<NOP>",
          ["gx"] = { desc = "Open path with syshandler" },
          ["g?"] = "<NOP>",
          ["gP"] = "<NOP>",
          ["gT"] = "<NOP>",
          ["g@"] = "<NOP>",
          ["g<Tab>"] = "<NOP>",
          ["g<C-i>"] = "<NOP>",
          ["g<C-I>"] = "<NOP>",
          ["A"] = { -- ISSUE: 1. Dot only repeats insertion
            function()
              local count = vim.v.count1
              local is_co = vim.fn.mode(true):find "ni"
              vim.cmd.normal { "g_", bang = true }
              if is_co then
                vim.api.nvim_feedkeys(vim.utils.termcodes "<C-o>", "n", false)
                local here = vim.api.nvim_win_get_cursor(0)
                here[2] = here[2] + 1
                vim.api.nvim_win_set_cursor(0, here)
              end
              vim.api.nvim_feedkeys(count .. "a", "n", true)
            end,
            desc = "Append to end of text line",
          },
          ["C"] = { '"_c', desc = "Change without yanking" },
          ["D"] = { '"_d', desc = "Delete without yanking" },
          ["J"] = {
            function() require("astrocore.buffer").nav(vim.v.count1) end,
            desc = "Next buffer",
          },
          ["K"] = {
            function() require("astrocore.buffer").nav(-vim.v.count1) end,
            desc = "Previous buffer",
          },
          ["S"] = "<NOP>",
          ["U"] = { "<C-r>", desc = "Redo" },
          ["Y"] = "<NOP>",
          ["ZZ"] = "<NOP>",
          ["ZQ"] = "<NOP>",
          ["."] = {
            function()
              for _ = 1, vim.v.count1 do
                vim.api.nvim_feedkeys(".", "n", true)
              end
            end,
            desc = "Repeat last change",
          },
          ["g+"] = "<NOP>",
          ["g-"] = "<NOP>",
          ["g<C-g>"] = "<NOP>", -- TODO: turn into ex command
          ["gA"] = { "A", desc = "Append to end of line" },
          ["gJ"] = "<NOP>",
          ["gt"] = "<NOP>",
          ["do"] = "<NOP>",
          ["dp"] = "<NOP>",
          ["q:"] = "<NOP>",
          ["g:"] = { "q:", desc = "Command window" },
          ["s"] = "<NOP>",
          ["QQ"] = "<NOP>",
          ["Q@"] = "<NOP>",
          ["@"] = "<NOP>",
          -- operator-doubled
          ["yy"] = "<NOP>",
          ["cc"] = "<NOP>",
          ["dd"] = "<NOP>",
          ["g~~"] = "<NOP>",
          ["g~g~"] = "<NOP>",
          ["gqq"] = "<NOP>",
          ["gqgq"] = "<NOP>",
          ["gww"] = "<NOP>",
          ["gwgw"] = "<NOP>",
          ["gUU"] = "<NOP>",
          ["gUgU"] = "<NOP>",
          ["guu"] = "<NOP>",
          ["gugu"] = "<NOP>",
          ["g??"] = "<NOP>",
          ["g?g?"] = "<NOP>",
          -- ["@@"] = "<NOP>",
          ["=="] = "<NOP>",
        },
        x = {
          ["<S-Space>"] = "<NOP>",
          ["<Space>"] = "<NOP>",
          ["<Leader>/"] = false,
          ["<BS>"] = { "<DEL>", desc = "Delete character or count" },
          ["<C-a>"] = "<NOP>",
          ["<C-g>"] = "<NOP>",
          ["<C-q>"] = "<NOP>",
          ["<C-x>"] = "<NOP>",
          ["<C-z>"] = "<NOP>",
          ["<S-BS>"] = { '"_<DEL>', desc = "Delete character without yanking" }, -- IDEA: this should also instantly reset counts when given
          -- ["~"] = { "g~", desc = "Switch case" }, -- just set tildeop
          -- ["g~"] = "<NOP>",
          ["&"] = ":&&<CR>",
          ["+"] = { "<C-a>", desc = "Increment" },
          ["-"] = { "<C-x>", desc = "Decrement" },
          ["~"] = "<NOP>",
          ["C"] = { '"_c', desc = "Change without yanking" }, -- it half-exists already
          ["D"] = { '"_d', desc = "Delete without yanking" },
          ["J"] = "<NOP>",
          ["K"] = "<NOP>",
          ["R"] = "<NOP>",
          ["S"] = "<NOP>",
          ["U"] = "<NOP>",
          ["u"] = "<NOP>",
          ["Y"] = "<NOP>",
          ["g<C-g>"] = "<NOP>", -- TODO: turn into ex command
          ["g+"] = { "g<C-a>", desc = "Increment sequentially" },
          ["g-"] = { "g<C-x>", desc = "Decrement sequentially" },
          ["g/"] = { "<esc>/\\%V", desc = "Search foward inside selection" },
          ["g?"] = { "<esc>?\\%V", desc = "Search backward inside selection" },
          ["gJ"] = "<NOP>",
          ["gx"] = { desc = "Open path with syshandler" },
          ["s"] = "<NOP>",
          ["q:"] = "<NOP>",
          ["g:"] = { "q:", desc = "Command window" },
          ["Q"] = {
            function()
              vim.cmd.normal {
                "q"
                  .. (
                    vim.fn.reg_recording() ~= "" and ""
                    or (vim.v.register == "+" or vim.v.register == '"' or vim.v.register == "*") and "q"
                    or vim.v.register
                  ),
                bang = true,
              }
            end,
            desc = "Record macro",
          },
          ["q"] = {
            function()
              vim.cmd.normal {
                "@"
                  .. (
                    (vim.v.register == "+" or vim.v.register == '"' or vim.v.register == "*") and "q"
                    or vim.v.register
                  ),
                bang = true,
              }
            end,
            desc = "Play macro",
          },
          ["QQ"] = "<NOP>",
          ["Q@"] = "<NOP>",
          ["@"] = "<NOP>",
          -- text-object
          ["aB"] = "<NOP>",
          ["ab"] = "<NOP>",
          ["iB"] = "<NOP>",
          ["ib"] = "<NOP>",
        },
        o = {
          ["<C-Space>"] = { "_", desc = "Entire line" },
          ["<Space>"] = { desc = "Current character" }, -- dsc
          ["+"] = "<NOP>",
          ["-"] = "<NOP>",
          -- text-object
          ["aB"] = "<NOP>",
          ["ab"] = "<NOP>",
          ["iB"] = "<NOP>",
          ["ib"] = "<NOP>",
          -- operator-doubled
          ["y"] = "<NOP>",
          ["c"] = "<NOP>",
          ["d"] = "<NOP>",
          ["g~"] = "<NOP>",
          ["gq"] = "<NOP>",
          ["gw"] = "<NOP>",
          ["gU"] = "<NOP>",
          ["gu"] = "<NOP>",
          ["g?"] = "<NOP>",
          ["="] = "<NOP>",
        },
        ["!"] = {
          ["<A->>"] = "<C-End>",
          ["<A-Del>"] = "<C-w>",
          ["<A-b>"] = "<S-Left>",
          ["<A-d>"] = "<C-Right><C-w>", -- FIXME: not the same as actual <A-d>, see `foo b*r baz` -> <A-d> -> <A-d>
          ["<A-f>"] = "<S-Right>",
          ["<A-lt>"] = "<C-Home>",
          ["<C-BS>"] = "<C-w>",
          ["<C-Del>"] = "<C-Right><C-w>", -- FIXME: not the same as actual <C-Del>, see `foo b*r baz` -> <C-Del> -> <C-Del>
          ["<C-a>"] = "<Home>",
          ["<C-b>"] = "<Left>",
          ["<C-d>"] = "<DEL>",
          ["<C-f>"] = "<Right>",
          ["<C-j>"] = "<NOP>",
          ["<C-CR>"] = "<NOP>",
          ["<C-Tab>"] = "<NOP>",
          ["<C-q>"] = "<NOP>",
          ["<S-CR>"] = "<NOP>",
          ["<C-_>"] = "<NOP>",
        },
        i = {
          ["<A-{>"] = "<C-o>{",
          ["<A-}>"] = "<C-o>}",
          ["<C-@>"] = "<NOP>",
          ["<C-S>"] = false,
          ["<C-Space>"] = "<NOP>",
          ["<C-c>"] = "<NOP>",
          ["<C-e>"] = "<End>",
          -- ["<C-k>"] = '<C-o>"_d$',
          -- ["<A-v>"] = "<C-k>"
          ["<C-s>"] = false,
          ["<C-n>"] = "<Down>",
          ["<C-p>"] = "<Up>",
          ["<C-t>"] = "<NOP>",
          ["<C-y>"] = "<NOP>",
          ["<C-\\>"] = "<NOP>",
          ["<C-\\><C-n>"] = "<NOP>",
          ["<C-\\><C-N>"] = "<NOP>",
          ["<C-\\><C-g>"] = "<NOP>",
          ["<C-\\><C-G>"] = "<NOP>",
          ["<S-Space>"] = "<NOP>",
          ["<S-Tab>"] = "<NOP>",
        },
        c = {
          ["<C-\\>e"] = "<NOP>",
          ["<C-\\>"] = "<C-\\>e",
          ["<C-z>"] = "<NOP>",
          -- ["<Esc>"] = "<C-f>", -- set cedit=^[
          ["<S-Tab>"] = "<C-d>",
          ["<Tab>"] = "<C-z>",
        },
        t = {
          ["<A-Esc>"] = "<C-\\><C-n>",
          ["<A-o>"] = "<C-\\><C-o>",
          ["<C-\\>"] = "<NOP>",
          ["<C-\\><C-N>"] = "<NOP>",
          ["<C-\\><C-O>"] = "<NOP>",
          ["<C-\\><C-n>"] = "<NOP>",
          ["<C-\\><C-o>"] = "<NOP>",
        },
      },
    },
  },
  {
    end,
  },
}
