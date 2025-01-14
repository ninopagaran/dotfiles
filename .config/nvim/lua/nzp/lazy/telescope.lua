return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  -- or                              , branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = { "Telescope" },
  config = function()
    require("telescope").setup({
      defaults = {
        -- Display path without leading './'
        path_display = function(_, path)
          return path:gsub("^%./", "")
        end,
      }
    })

    -- local builtin = require('telescope.builtin')
    -- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    -- vim.keymap.set('n', '<leader>pws', function()
    --   local word = vim.fn.expand("<cword>")
    --   builtin.grep_string({ search = word })
    -- end)
    -- vim.keymap.set('n', '<leader>pWs', function()
    --   local word = vim.fn.expand("<cWORD>")
    --   builtin.grep_string({ search = word })
    -- end)
    -- vim.keymap.set('n', '<leader>ps', function()
    --   builtin.grep_string({ search = vim.fn.input("Grep > ") })
    -- end)
    -- vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
  end,
  keys = {
    { 
      '<C-p>', function () require("telescope.builtin").git_files() end 
    },
    {
      '<leader>vh', function() require("telescope.builtin").help_tags() end },
    {
      "<leader>pf", function()
        require("telescope.builtin").find_files({
          hidden = true,
          find_command = {
            "rg", "--files", "--hidden",
            "--glob=!.git/**",
            "--glob=!node_modules/**",
            "--glob=!tmp/**"
          }
        })
      end,
      { noremap = true, silent = true }
    },
    {
      "<leader>pws", function()
        local word = vim.fn.expand("<cword>")
        require("telescope.builtin").grep_string({ search = word })
      end
    },
    {
      '<leader>pWs', function()
        local word = vim.fn.expand("<cWORD>")
        require("telescope.builtin").grep_string({ search = word })
      end
    },
    {
      '<leader>ps', function()
        require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
      end
    }
  }
}
