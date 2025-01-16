return {
   {
      'echasnovski/mini.move',
      version = '*',
      config = function()
         require('mini.move').setup()
      end,
   },
   {
      'echasnovski/mini.visits',
      version = '*',
      config = function()
         require('mini.visits').setup()
      end,
   },
   {
      'echasnovski/mini.surround',
      version = '*',
      config = function()
         require('mini.surround').setup({
            mappings = {
               add = 'gsa',
               delete = 'gsd',
               find = 'gsf',
               find_left = 'gsF',
               highlight = 'gsh',
               replace = 'gsr',
               update_n_lines = 'gsn',

               suffix_last = 'l',
               suffix_next = 'n',
            }
         })
      end,
   },
   {
      'echasnovski/mini.splitjoin',
      version = '*',
      config = function()
         require('mini.splitjoin').setup()
      end,
   },
   {
      'echasnovski/mini.map',
      version = '*',
      config = function()
         require('mini.map').setup()
      end,
   },
   {
      'echasnovski/mini.comment',
      version = '*',
      config = function()
         require('mini.comment').setup()
      end,
   },
   -- {
   --    'echasnovski/mini.icons',
   --    version = '*',
   --    config = function()
   --       require('mini.icons').setup()
   --    end,
   -- },
   {
      'echasnovski/mini.misc',
      version = '*',
      config = function()
         require('mini.misc').setup()
      end,
   },
   -- {
   --    'echasnovski/mini.completion',
   --    version = '*',
   --    config = function()
   --       require('mini.completion').setup()
   --    end,
   -- },
   {
      'echasnovski/mini.pairs',
      version = '*',
      config = function()
         require('mini.pairs').setup({
            modes = { insert = true, command = false, terminal = false },
            mappings = {
               ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
               ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
               ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

               [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
               [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
               ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

               ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
               ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
               ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
            }
         })
      end,
   },
}
