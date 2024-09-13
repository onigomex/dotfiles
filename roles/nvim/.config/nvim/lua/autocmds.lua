-- ref. https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Remove whitespace on save
autocmd("BufWritePre", {
	pattern = "*",
	command = ":%s/\\s\\+$//e",
})

-- Always open the terminal in insert mode (and nonumber, laststatus=0)
autocmd("TermOpen", {
	pattern = "*",
	command = "set nonumber\nset laststatus=0\nstartinsert"
})
