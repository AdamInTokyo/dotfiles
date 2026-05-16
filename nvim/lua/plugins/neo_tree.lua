return {
   'nvim-neo-tree/neo-tree.nvim',
   version = '*',
   dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
   },
   cmd = 'Neotree',
   keys = {
      { '\\',     ':Neotree toggle=true reveal=true position=left<CR>',  desc = 'NeoTree sidebar',         silent = true },
      { '<C-\\>', ':Neotree toggle=true reveal=true position=float<CR>', desc = 'NeoTree floating window', silent = true },
   },
   opts = {
      filesystem = {
         window = {
            mappings = {
               ['\\'] = 'close_window',
            },
         },
      },
      event_handlers = {
         {
            event = 'after_render',
            handler = function()
               local state = require('neo-tree.sources.manager').get_state('filesystem')
               if state.current_position == "left" then
                   return
               end
               if not require('neo-tree.sources.common.preview').is_active() then
                  state.config = { use_float = true }
                  state.commands.toggle_preview(state)
               end
            end
         },
      },
   },
}
