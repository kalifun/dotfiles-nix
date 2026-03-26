return {
  {
    "f-person/git-blame.nvim",
    event = "BufReadPre",
    opts = function()
      vim.g.gitblame_date_format = "%r"
    end,
    keys = {
      { "<leader>ug", "<CMD>GitBlameToggle<CR>", desc = "Toggle GitBlame" },
    },
  },
}
