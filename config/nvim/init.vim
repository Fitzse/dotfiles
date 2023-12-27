set nocompatible
set autowrite
set hidden
filetype off

let g:python3_host_prog = '/usr/bin/python3'
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0

" Load Plugins
source $HOME/repositories/dotfiles/config/nvim/plugins.vim

" Map Leader
let mapleader=" "

" Disable arrows
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Split Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Indents
set smartindent
set smarttab
set smartcase
set autoindent
set expandtab
set tabstop=4

" Line Numbers
set number

" Syntax
syntax on
filetype plugin indent on
set showmatch

" Colours
set termguicolors

set background=dark
colorscheme one
let g:one_allow_italics = 1

" Default to 2 spaces per tab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Completion options
set completeopt=menu,menuone,noselect

" Telescope
nnoremap <silent> <leader>f <cmd>Telescope find_files<cr>
nnoremap <silent> <leader>g <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>b <cmd>Telescope buffers<cr>

" Tree
nnoremap <silent> <leader>e :NvimTreeFindFile<cr>
nnoremap <silent> <leader>et :NvimTreeToggle<cr>

" Telescope
nnoremap <silent> <leader>f <cmd>Telescope find_files<cr>
nnoremap <silent> <leader>g <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>b <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>gb <cmd>Telescope git_branches<cr>
nnoremap <silent> <leader>gs <cmd>Telescope git_status<cr>
nnoremap <silent> <leader>s <cmd>Telescope treesitter<cr>
nnoremap <silent> gr <cmd>Telescope lsp_references<cr>

" Trouble
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>

" Go LSP Config
lua << EOF
require('lualine').setup()

local cmp = require'cmp'
cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
    }),
    sources = {
      { name = 'nvim_lsp' },
    }
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  buf_set_keymap("n", "<space>m", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end

require'lspconfig'.gopls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}

require("trouble").setup {}

local telescope = require("telescope")
telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require('telescope.actions').close,
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
      }
    }
  },
})
telescope.load_extension('fzf')

require("nvim-tree").setup()
require("Comment").setup()

require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "lua", "vim", "vimdoc", "go", "hcl" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})
EOF

autocmd BufWritePre *.go lua vim.lsp.buf.format()
