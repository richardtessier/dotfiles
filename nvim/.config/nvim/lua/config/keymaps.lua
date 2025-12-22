-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	---@cast keys LazyKeysHandler
	-- do not create the keymap if a lazy keys handler exists
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

-- Easy copy to / from clipboard
map({ "n", "v" }, "<Leader>y", '"+y', { noremap = true, desc = "Yank to clipboard" })
map("n", "<Leader>ya", ":%+y<CR>", { noremap = true, desc = "Yank all to clipboard" })
map("n", "<Leader>p", '"+p', { noremap = true, desc = "Put clipboard" })
map("n", "<Leader>P", '"+P', { noremap = true, desc = "Put clipboard" })
--map("n", "<D-V>", '"+gP', { noremap = true })

-- Buffer navigation
map("n", "<Leader>bn", "<cmd>bn<cr>", { noremap = true, desc = "Next buffer" })
map("n", "<Leader>bp", "<cmd>bp<cr>", { noremap = true, desc = "Prev buffer" })

-- LSP navigation
map("n", "<Leader>jdn", "<cmd>lua vim.diagnostic.goto_next()<cr>", { noremap = true, desc = "Next diagnostic" })
map("n", "<Leader>jdp", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { noremap = true, desc = "Previous diagnostic" })

-- French Canadian remapping
map("n", "<c-y>", "<C-]><cr>", { noremap = true, desc = "Jump into" })

-- Jumps via leader
map("n", ",ji", "<C-]><cr>", { noremap = true, desc = "Jump into" })

-- map({ "n", "i" }, "ç", "]", { noremap = true, desc = "" })
-- map({ "n", "i" }, "^", "[", { noremap = true, desc = "" })
-- map({ "n", "i" }, "à", "]", { noremap = false, desc = "" })
-- map({ "n", "i" }, "è", "[", { noremap = false, desc = "" })
-- map({ "n", "i" }, "À", "}", { noremap = false, desc = "" })
-- map({ "n", "i" }, "È", "{", { noremap = false, desc = "" })
--
map("i", "jj", "<ESC>", { noremap = true, desc = "Quick ESC" })
-- map("ni", "çt", "]t", { noremap = true, desc = "Square bracket" })
--

-- Resume last
-- vim.keymap.set("n", "<leader>sx", require("telescope.builtin").resume, { noremap = true, desc = "Resume" })
