-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- vim.g.zenbones_darkness = "warm"
-- vim.cmd([[ let g:zenbones = #{ lightness:  "dim", darkness: "stark" } ]])

require("lualine").setup({
  options = { section_separators = "", component_separators = "" },
})

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-y>"] = require("telescope.actions.layout").toggle_preview,
      },
    },
    preview = {
      hide_on_startup = false, -- hide previewer when picker starts
    },
  },
})

-- Command to start up Jupynium for working with notebooks:
vim.api.nvim_create_user_command("StartServer", function()
  vim.fn.serverstart("localhost:18898")
  vim.cmd(
    '99TermExec cmd="jupynium --nvim_listen_addr localhost:18898 --notebook_URL localhost:8080" open=0 name="Jupynium"'
  )
end, { desc = "start up Jupynium for working with notebooks" })

-- Command to ssh into SatoLabDry1:
vim.api.nvim_create_user_command("SSH1", function()
  vim.cmd(
    '1TermExec cmd="tmux new -A -s local && ssh adam@192.168.0.93 -t /home/adam/.local/bin/jupyter-console --existing" open=0 name="Console"'
  )
  vim.cmd("1ToggleTerm")
  vim.cmd("startinsert!")
end, { desc = "ssh into SatoLabDry1" })

vim.api.nvim_create_user_command("Tmux1", function()
  vim.cmd('1TermExec cmd="tmux new -A -s local"')
  vim.cmd("startinsert!")
end, { desc = "ssh into SatoLabDry1" })

-- Run local Jupyter console in toggleterm
vim.api.nvim_create_user_command("Console", function()
  vim.cmd('1TermExec cmd="jupyter-console --existing" open=1 name="Console"')
end, { desc = "local Jupyter console" })

-- disable paired parenthesis
vim.g.minipairs_disable = true
