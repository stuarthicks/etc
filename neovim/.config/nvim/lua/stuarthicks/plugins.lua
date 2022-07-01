-- vi: set ft=lua ts=2 sw=2 expandtab :

local fn = vim.fn
local path = require 'nvim-lsp-installer.core.path'
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local install_root_dir = path.concat {vim.fn.stdpath 'data', 'lsp_servers'}
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'

  use 'dense-analysis/ale'
  use 'ingsme/nvim-smyck'
  use 'neovim/nvim-lspconfig'
  use 'sheerun/vim-polyglot'
  use 'tomtom/tcomment_vim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'williamboman/nvim-lsp-installer'
  use { 'RRethy/nvim-align', cmd = 'Align' }
  use { 'bronson/vim-trailing-whitespace', cmd = {'FixWhitespace'} }
  use { 'jamessan/vim-gnupg', ft = {'asc'} }
  use { 'jremmen/vim-ripgrep', cmd = {'Rg'} }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'preservim/nerdtree', cmd = {'NERDTreeToggle'} }

  -- SLOW
  use 'ray-x/go.nvim'

  use { 'ray-x/navigator.lua', requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make' }}

  if packer_bootstrap then
    require('packer').sync()
  end

  require('telescope').load_extension('fzf')

  require'nvim-web-devicons'.setup {
   default = true;
  }

  require('go').setup({
    fillstruct = 'gopls',
    max_line_len = 1000,
    lsp_cfg = false,
  })

end,
  config = {
    profile = {
      enable = true,
      threshold = 0, -- ms
    },
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single', style = 'minimal' })
      end
    }
  },
})
