return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    -- Custom action to copy file path to clipboard
    local function copy_file_path(prompt_bufnr)
      local entry = action_state.get_selected_entry()
      local file_path = entry.cwd .. "/" .. entry.value  -- Full path
      vim.fn.setreg("+", file_path)  -- Copy to system clipboard
      vim.notify("Copied to clipboard: " .. file_path, vim.log.levels.INFO)
      actions.close(prompt_bufnr)
    end

    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-y>"] = copy_file_path,  -- Copy in insert mode
          },
          n = {
            ["<C-y>"] = copy_file_path,  -- Copy in normal mode
          },
        },
      },
    })

    local builtin = require("telescope.builtin")

    -- Keymaps with descriptions for which-key
    vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "[P]roject [F]iles" })
    vim.keymap.set("n", "<leader>pg", builtin.git_files, { desc = "Git files" })

    vim.keymap.set("n", "<leader>pws", function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end, { desc = "[P]roject [W]ord [S]earch (current word)" })

    vim.keymap.set("n", "<leader>pWs", function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end, { desc = "[P]roject [W]ORD [S]earch (current WORD)" })

    vim.keymap.set("n", "<leader>ps", function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, { desc = "[P]roject [S]earch" })

    vim.keymap.set("n", "<leader>v0", builtin.help_tags, { desc = "[V]im [H]elp tags" })
  end,
}
