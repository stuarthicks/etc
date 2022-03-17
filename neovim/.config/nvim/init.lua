-- vi: set ft=lua ts=2 sw=2 expandtab :
require('stuarthicks.plugins')
require('stuarthicks.treesitter')
require('stuarthicks.lsp')

local term_program = os.getenv('TERM_PROGRAM')
vim.o.termguicolors = true
if term_program == 'Apple_Terminal' then
  vim.o.termguicolors = false
end

vim.o.background = 'dark'
vim.cmd [[
  colorscheme nvim-smyck
  highlight Normal guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.g.netrw_altv = 1
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 20

-- vim.o.clipboard ^= {'unnamed','unnamedplus'}
-- vim.o.path += '**'
-- vim.o.shortmess += 'c'
vim.o.backspace = table.concat({
  'indent',
  'eol',
  'start',
}, ',')
vim.o.backup = false
vim.o.completeopt = table.concat({
  'longest',
  'menuone',
}, ',')
vim.o.expandtab = true
vim.o.foldlevelstart = 20
vim.o.foldmethod = 'syntax'
vim.o.mouse = 'a'
vim.o.number = true
vim.o.scrolloff = 5
vim.o.shiftwidth = 2
vim.o.sidescrolloff = 5
vim.o.signcolumn = 'number'
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.timeoutlen = 300
vim.o.updatetime = 300
vim.o.wildignore = table.concat({
  '*/.idea/*',
  '*/.git/*',
  '*/.svn/*',
  '*/vendor/*',
  '*/node_modules/*',
}, ',')
vim.o.wildmode = 'longest,list'
vim.o.winhighlight = 'Normal:None'
vim.o.wrap = false
vim.o.writebackup = false

local map = function(key)
  -- get the extra options
  local opts = {noremap = true}
  for i, v in pairs(key) do
    if type(i) == 'string' then opts[i] = v end
  end

  -- basic support for buffer-scoped keybindings
  local buffer = opts.buffer
  opts.buffer = nil

  if buffer then
    vim.api.nvim_buf_set_keymap(0, key[1], key[2], key[3], opts)
  else
    vim.api.nvim_set_keymap(key[1], key[2], key[3], opts)
  end
end

map {'n', ';', ':'}
map {'n', 'q:', '<nop>'}
map {'n', 'Q', '@q'}
map {'t', '<ESC>', '<C-\\><C-n>'}
map {'v', '<', '<gv'}
map {'v', '>', '>gv'}

map {'n', '<Leader><space>', ':nohlsearch<cr>', silent = true}
map {'n', '<leader>h', ':vertical help<space>'}
map {'n', '<leader>t', ':split +term<cr>'}

map {'n', '<leader>p', ':NERDTreeToggle<cr>'}
map {'n', '<leader>r', ':Rg<space>'}

map {'n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>'}
map {'n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>'}
map {'n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>'}
map {'n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>'}
