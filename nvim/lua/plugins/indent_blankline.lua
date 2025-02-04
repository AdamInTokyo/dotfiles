return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  -- event = "VeryLazy",
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    indent = {
    char = "│",
    tab_char = "│",
    },
    scope = { show_start = false, show_end = false },
    exclude = {
    filetypes = {
      "Trouble",
      "alpha",
      "dashboard",
      "help",
      "lazy",
      "mason",
      "neo-tree",
      "notify",
      "snacks_notif",
      "snacks_terminal",
      "snacks_win",
      "toggleterm",
      "trouble",
      },
    },
  },
  -- config = function(_, opts)
  --   require("ibl").setup(opts)
  -- end,
}
