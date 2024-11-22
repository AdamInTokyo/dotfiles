return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  -- add zenbones
  {
    "mcchrish/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    config = function()
      vim.o.background = "light"
      vim.g.zenbones_darkness = "warm"
      vim.g.zenbones_lightness = "dim"
    end,
  },
  -- Configure LazyVim to load gruvbox

  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "zenbones",
  --   },
  -- },
}
