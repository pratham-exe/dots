local opts = { noremap = true, silent = true }
local autocmd = vim.api.nvim_create_autocmd
autocmd("FileType", { pattern = "python",
	callback = function()
		vim.api.nvim_buf_set_keymap(0,"n","<C-c>",":vsplit<CR>:te python3 '%'<CR>i",opts)
	end})
autocmd("FileType", { pattern = "cpp",
	callback = function()
		vim.api.nvim_buf_set_keymap(0,"n","<C-c>",":vsplit<CR>:te g++ -std=c++14 -Wshadow -Wall % -g -D_GLIBCXX_DEBUG && ./a.out<CR>i",opts)
	end})
autocmd("FileType", { pattern = "c",
	callback = function()
		vim.api.nvim_buf_set_keymap(0,"n","<C-c>",":vsplit<CR>:te gcc -Wshadow -Wall % -g -D_GLIBCXX_DEBUG && ./a.out<CR>i",opts)
	end})
autocmd("FileType", { pattern = "rust",
	callback = function()
		vim.api.nvim_buf_set_keymap(0,"n","<C-c>",":vsplit<CR>:te rustc % -g && ./%:t:r<CR>i",opts)
	end})
autocmd("FileType", { pattern = "javascript",
	callback = function()
		vim.api.nvim_buf_set_keymap(0,"n","<C-c>",":vsplit<CR>:te node '%' <CR>i",opts)
	end})
