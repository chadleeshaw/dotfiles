-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Plugin list
require("lazy").setup({
	-- lua utilities used by many plugins
	"nvim-lua/plenary.nvim",

	-- colorscheme
	"folke/tokyonight.nvim",

	-- tmux & split window navigation
	"christoomey/vim-tmux-navigator",

	-- maximise/restore current window
	"szw/vim-maximizer",

	-- surround selections with characters
	"tpope/vim-surround",

	-- replace with register contents (gr + motion)
	"inkarkat/vim-ReplaceWithRegister",

	-- commenting with gc
	{ "numToStr/Comment.nvim", config = true },

	-- file explorer
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- statusline
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

	-- fuzzy finding
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},

	-- autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"onsails/lspkind.nvim",
			-- snippets
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
	},

	-- formatting & linting
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"jay-babu/mason-null-ls.nvim",
		},
	},

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
	},

	-- auto-closing pairs
	"windwp/nvim-autopairs",

	-- git decorations
	"lewis6991/gitsigns.nvim",

	-- git diff / file history viewer
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- keymap popup (shows available keys after leader)
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
	},

	-- diagnostic / quickfix list UI
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- indent guides
	"lukas-reineke/indent-blankline.nvim",

	-- file bookmarks for fast project navigation
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- LSP symbol outline panel
	{
		"hedyhli/outline.nvim",
	},
}, {
	-- lazy.nvim options
	ui = {
		border = "rounded",
	},
})
