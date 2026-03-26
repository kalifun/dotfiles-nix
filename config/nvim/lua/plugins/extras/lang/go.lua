return {
  {
    "olexsmir/gopher.nvim",
    enabled = true,
    event = "VeryLazy",
    dependencies = { -- dependencies
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("gopher").setup({})
    end,
    keys = {
      {
        "<leader>gsj",
        "<cmd> GoTagAdd json <CR>",
        "Add json struct tags",
      },
      {
        "<leader>gsy",
        "<cmd> GoTagAdd yaml <CR>",
        "Add yaml struct tags",
      },
      {
        "<leader>gmt",
        "<cmd> GoMod tidy <CR>",
        "Go mod tidy",
      },
      {
        "<leader>ggc",
        "<cmd> GoGenerate % <CR>",
        "Go generate for current file",
      },
      {
        "<leader>gtf",
        "<cmd> GoTestsAll <CR>",
        "Go generate all tests for all function/methods in current file",
      },
      {
        "<leader>gto",
        "<cmd> GoTestAdd <CR>",
        "Go generate ont test for a specific function/methods",
      },
      {
        "<leader>gie",
        "<cmd> GoIfErr <CR>",
        "Set cursor on the line with err",
      },
    },
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
  },
}
