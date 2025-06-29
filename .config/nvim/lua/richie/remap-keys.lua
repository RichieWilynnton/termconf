vim.g.mapleader = " "

--Make d not copy to clipboard 
vim.keymap.set('n', 'd', '"_d', { noremap = true })
vim.keymap.set('v', 'd', '"_d', { noremap = true })

vim.keymap.set('n', '<leader>cc', ':CopilotChatOpen<CR>', { noremap = true, silent = true })
