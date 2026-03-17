local ok, harpoon = pcall(require, "harpoon")
if not ok then
	return
end

harpoon:setup()

local keymap = vim.keymap
-- add current file to harpoon list
keymap.set("n", "<leader>aa", function() harpoon:list():add() end,           { desc = "Harpoon: add file" })
-- open harpoon quick menu
keymap.set("n", "<leader>am", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: menu" })

-- jump to files 1-5 in harpoon list
keymap.set("n", "<leader>a1", function() harpoon:list():select(1) end,       { desc = "Harpoon: file 1" })
keymap.set("n", "<leader>a2", function() harpoon:list():select(2) end,       { desc = "Harpoon: file 2" })
keymap.set("n", "<leader>a3", function() harpoon:list():select(3) end,       { desc = "Harpoon: file 3" })
keymap.set("n", "<leader>a4", function() harpoon:list():select(4) end,       { desc = "Harpoon: file 4" })
keymap.set("n", "<leader>a5", function() harpoon:list():select(5) end,       { desc = "Harpoon: file 5" })

-- cycle through harpoon list
keymap.set("n", "<leader>ap", function() harpoon:list():prev() end,          { desc = "Harpoon: prev" })
keymap.set("n", "<leader>an", function() harpoon:list():next() end,          { desc = "Harpoon: next" })
