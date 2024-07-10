-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Alacritty
local alacrittyAutoGroup = vim.api.nvim_create_augroup("alacritty", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  group = alacrittyAutoGroup,
  callback = function()
    vim.fn.system(
      "alacritty msg --socket $ALACRITTY_SOCKET config -w $ALACRITTY_WINDOW_ID options 'window.padding.x=0' 'window.padding.y=0' 'window.dynamic_padding=false'"
    )
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = alacrittyAutoGroup,
  callback = function()
    vim.fn.jobstart("alacritty msg --socket $ALACRITTY_SOCKET config -w $ALACRITTY_WINDOW_ID -r", { detach = true })
  end,
})
