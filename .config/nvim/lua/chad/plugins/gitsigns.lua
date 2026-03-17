-- import gitsigns plugin safely
local setup, gitsigns = pcall(require, "gitsigns")
if not setup then
	return
end

gitsigns.setup({
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns
		local opts = { buffer = bufnr, silent = true }

		-- navigation
		vim.keymap.set("n", "]h", gs.next_hunk, opts) -- next hunk
		vim.keymap.set("n", "[h", gs.prev_hunk, opts) -- prev hunk

		-- actions
		vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts) -- stage hunk
		vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts) -- reset hunk
		vim.keymap.set("n", "<leader>hS", gs.stage_buffer, opts) -- stage buffer
		vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, opts) -- undo stage hunk
		vim.keymap.set("n", "<leader>hR", gs.reset_buffer, opts) -- reset buffer
		vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts) -- preview hunk
		vim.keymap.set("n", "<leader>hb", function() gs.blame_line({ full = true }) end, opts) -- blame line
		vim.keymap.set("n", "<leader>hd", gs.diffthis, opts) -- diff this
	end,
})
