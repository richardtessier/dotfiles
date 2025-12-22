-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","
-- vim.opt.laststatus = 2
-- vim.opt.winbar = "%=%m %f"
vim.opt.clipboard = nil
--
-- for edgy
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.opt.splitkeep = "screen"

if vim.g.neovide then
	vim.keymap.set({ "n", "v", "s", "x", "o", "i", "l", "c", "t" }, "<D-v>", function()
		vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
	end, { noremap = true, silent = true })
	-- vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
	-- vim.keymap.set('v', '<D-c>', '"+y') -- Copy
	-- vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
	-- vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
	-- vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
	-- vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
end
