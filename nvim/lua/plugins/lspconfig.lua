return {
  "nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = true },
    document_highlight = { enabled = false }, --disable lsp cursor word highlighting
    settings = {
      python = {
        -- makes sure the python path is set to the conda env's python3 executable
        pythonPath = vim.fn.system("echo $(which python)3"):gsub("\n", ""),
      },
    },
    servers = {
      -- Settings for basedpyright:
      basedpyright = {
        settings = {
          python = {
            -- makes sure the python path is set to the conda env's python3 executable
            pythonPath = vim.fn.system("echo $(which python)3"):gsub("\n", ""),
          },
          basedpyright = {
            typeCheckingMode = "none",
          },
        },
      },
    },
  },
}
