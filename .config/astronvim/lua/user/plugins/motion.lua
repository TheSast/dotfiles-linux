return {
  {
    "ggandor/leap.nvim",
    keys = {
      {
        "s",
        "<Plug>(leap-forward-to)",
        mode = {
          "n",
          "x",
          "o",
        },
        desc = "Leap forward to",
      },
      {
        "S",
        "<Plug>(leap-backward-to)",
        mode = {
          "n",
          "x",
          "o",
        },
        desc = "Leap backward to",
      },
    },
    opts = {
      safe_labels = {},
    },
    dependencies = {
      "tpope/vim-repeat",
    },
  },
  { "AstroNvim/astrocommunity", version = "*" },
  { import = "astrocommunity.motion.nvim-surround" },
  {
    "nvim-surround",
    opts = {
      keymaps = {
        insert = false,
        insert_line = false,
        normal = "gs",
        normal_cur = false,
        normal_line = false,
        normal_cur_line = false,
        visual = "gs",
        visual_line = false,
        delete = "d" .. "gs",
        change = "c" .. "gs",
      },
    },
  },
  { import = "astrocommunity.motion.portal-nvim" },
  {
    "portal.nvim",
    keys = function()
      return {
        { "g" .. "<C-o>", "<cmd>Portal jumplist backward<CR>", desc = "Portal Jump backward" },
        { "g" .. "<C-i>", "<cmd>Portal jumplist forward<CR>", desc = "Portal Jump forward" },
      }
    end,
  },
  { import = "astrocommunity.motion.grapple-nvim" },
  {
    "grapple.nvim",
    keys = function()
      return {
        { "<leader><leader>", desc = "Grapple" },
        { "<leader><leader>" .. "a", "<cmd>GrappleTag<CR>", desc = "Add file" },
        { "<leader><leader>" .. "d", "<cmd>GrappleUntag<CR>", desc = "Remove file" },
        { "<leader><leader>" .. "e", "<cmd>GrapplePopup tags<CR>", desc = "Select from tags" },
        { "<leader><leader>" .. "s", "<cmd>GrapplePopup scopes<CR>", desc = "Select a project scope" },
        { "<leader><leader>" .. "x", "<cmd>GrappleReset<CR>", desc = "Clear tags from current project" },
      }
    end,
  },
  { import = "astrocommunity.motion.mini-move" },
  { import = "astrocommunity.motion.nvim-spider" },
}
