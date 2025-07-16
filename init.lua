-- Set the leader key early
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Options
local options = {
	bg = "light",
	backup = false,
	clipboard = "unnamedplus",
	cmdheight = 2,
	completeopt = { "menuone", "noselect" },
	conceallevel = 0,
	fileencoding = "utf-8",
	hlsearch = true,
	ignorecase = true,
	pumheight = 10,
	showmode = false,
	showtabline = 2,
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	--termguicolors = true, -- uncomment if your terminal supports true colors
	ttimeoutlen = 100,
	undofile = true,
	updatetime = 300,
	shiftwidth = 2,
	tabstop = 2,
	cursorline = false,
	number = true,
	relativenumber = false,
	numberwidth = 4,
	signcolumn = "yes",
	wrap = false,
	scrolloff = 8,
	sidescrolloff = 8,
	--guifont = "monospace:h17",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd [[
	try
		colorscheme nord-vim
	catch /^Vim\%((\a\+)\)\=:E185/
		colorscheme default
		set background=dark
	endtry
]]

-- Keys
local opts_noremap_silent = { noremap = true, silent = true }
local term_opts_silent = { silent = true } -- Not used in this snippet but kept for context

-- Set Space as <Nop>
vim.keymap.set("", "<SPACE>", "<Nop>", opts_noremap_silent)
-- Remap jj to Esc for insert mode
vim.keymap.set("i", "jj", "<ESC>", opts_noremap_silent)

-- NERDTree Mappings (Using vim.keymap.set)
vim.keymap.set('n', '<leader>n', ':NERDTreeFocus<CR>', { desc = 'Focus NERDTree' })
vim.keymap.set('n', '<C-n>', ':NERDTree<CR>', { desc = 'Open NERDTree' })
vim.keymap.set('n', '<C-t>', ':NERDTreeToggle<CR>', { desc = 'Toggle NERDTree' })
vim.keymap.set('n', '<C-f>', ':NERDTreeFind<CR>', { desc = 'Find current file in NERDTree' })

-- Lazy.nvim Setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Lazy.nvim Plugin Configuration
require("lazy").setup({
	'nvim-treesitter/nvim-treesitter',
	{
    'preservim/nerdtree',
    cmd = 'NERDTreeToggle', -- Lazily load NERDTree when this command is called
    config = function()
      -- Your NERDTree keybindings go here
      vim.keymap.set('n', '<leader>n', ':NERDTreeFocus<CR>', { desc = 'Focus NERDTree' })
      vim.keymap.set('n', '<C-n>', ':NERDTree<CR>', { desc = 'Open NERDTree' })
      vim.keymap.set('n', '<C-t>', ':NERDTreeToggle<CR>', { desc = 'Toggle NERDTree' })
      vim.keymap.set('n', '<C-f>', ':NERDTreeFind<CR>', { desc = 'Find current file in NERDTree' })

      -- Optional: Configure NERDTree settings here if you have any
      -- vim.g.NERDTreeShowHidden = 1
      -- vim.g.NERDTreeQuitOnOpen = 1
    end,
  },
	{
		'nvim-tree/nvim-web-devicons',
		lazy = true, -- Only load when needed by other plugins
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {}, -- Empty opts table if no specific global options are needed
		config = function(_, opts)
			require("flash").setup(opts)

			-- Flash Mappings
			vim.keymap.set({ "n", "x", "o" }, "s", function()
				require("flash").jump()
			end, { desc = "Flash Jump" })

			vim.keymap.set({ "n", "x", "o" }, "S", function()
				require("flash").treesitter()
			end, { desc = "Flash Treesitter" })

			vim.keymap.set("n", "r", function()
				require("flash").remote()
			end, { desc = "Flash Remote" })

			vim.keymap.set({ "n", "x", "o" }, "f", function()
				require("flash").jump({ pattern = "^.", first = true, fwd = true })
			end, { remap = true, desc = "Flash Fwd Char" })

			vim.keymap.set({ "n", "x", "o" }, "F", function()
				require("flash").jump({ pattern = "^.", first = true, fwd = false })
			end, { remap = true, desc = "Flash Bwd Char" })

			vim.keymap.set({ "n", "x", "o" }, "t", function()
				require("flash").jump({ pattern = "^.", first = true, till = true, fwd = true })
			end, { remap = true, desc = "Flash Fwd Till Char" })

			vim.keymap.set({ "n", "x", "o" }, "T", function()
				require("flash").jump({ pattern = "^.", first = true, till = true, fwd = false })
			end, { remap = true, desc = "Flash Bwd Till Char" })
		end,
	},
})
