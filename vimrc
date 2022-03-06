imap jj <Esc>
set number

syntax on
set nu ru et
set hlsearch
set ts=4
set sts=4
set sw=4
set encoding=utf8

set splitbelow
set splitright
set autowrite
set mouse=a

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has("nvim"))
"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
    set termguicolors
endif

map <C-s> :w<CR>

set nocompatible
set ignorecase
set hlsearch
set incsearch
set nowrap

set noerrorbells

" trust version control
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

nnoremap <space> <Nop>
let g:mapleader=' '
let mapleader=' '

call plug#begin("~/.vim/plugged")
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'joshdick/onedark.vim'
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'numToStr/Comment.nvim'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'kyazdani42/nvim-web-devicons' " for file icons

    Plug 'neovim/nvim-lspconfig'
    Plug 'SirVer/ultisnips'

    Plug 'mfussenegger/nvim-dap'
    Plug 'windwp/nvim-autopairs'
    Plug 'Pocco81/DAPInstall.nvim'
    Plug 'rcarriga/nvim-dap-ui'

    Plug 'christoomey/vim-tmux-navigator'

    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
    Plug 'nvim-neorg/neorg'

    Plug 'dart-lang/dart-vim-plugin'
    Plug 'akinsho/flutter-tools.nvim'

call plug#end()

au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>

" Find files using Telescope command-line sugar
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" dap mappings
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

" lsp navigation shortcuts
set completeopt=menu,menuone,noselect

lua <<EOF
    -- auto pairs
    local nvimtree = require('nvim-tree')
    require('nvim-autopairs').setup{}
    nvimtree.setup{
        auto_close = true,
        open_on_setup = true,
        view = {
            auto_resize = true
        }
    }
    require('telescope').setup{}
    require('nvim-treesitter.configs').setup{
        highlight = {
            enable = true
        }
    }
    require('Comment').setup()

    local dapui = require('dapui')
    dapui.setup()
    local dap = require("dap")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
      nvimtree.close()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
      nvimtree.open()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
      nvimtree.open()
    end

    local dapInstallPath = os.getenv('HOME') .. '/.local/share/nvim/dapinstall/'
    dap.adapters.go = {
        type = 'executable',
        command = 'node',
        args = {dapInstallPath .. 'go/vscode-go/dist/debugAdapter.js'};
    }

    dap.configurations.go = {
      {
        type = 'go',
        name = 'Debug',
        request = 'launch',
        showLog = false,
        program = "${file}",
        dlvToolPath = vim.fn.exepath('dlv')
      },
    }

    vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
    
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<M-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ['<M-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' }, -- For ultisnips users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  local buf_map = function(bufnr, mode, lhs, rhs, opts) 
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
            silent = true,
        })
    end

  -- Setup lspconfig.
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      -- Mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end

    local lspconfig = require('lspconfig')

    local servers = { 'gopls', 'vimls', 'svelte', 'sumneko_lua'}
    for _, lsp in pairs(servers) do
      lspconfig[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
          -- This will be the default in neovim 0.7+
          debounce_text_changes = 150,
        },
        
      }
    end

    lspconfig.tsserver.setup({
        on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false
            local ts_utils = require("nvim-lsp-ts-utils")
            ts_utils.setup({})
            ts_utils.setup_client(client)
            buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
            buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
            buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
            on_attach(client, bufnr)
        end,
    })

    local null_ls = require("null-ls")
    null_ls.setup({
        sources = {
            null_ls.builtins.diagnostics.eslint,
            null_ls.builtins.code_actions.eslint,
            null_ls.builtins.formatting.prettier
        },
        on_attach = on_attach
    })
    
    require("flutter-tools").setup{}

    require('neorg').setup {
        load = {
            ["core.defaults"] = {},
            -- ["core.integrations.telescope"] = {},
            ["core.norg.concealer"] = {
                config = {
                    icon_preset = "diamond",
                    markup_preset = "dimmed",
                    dim_code_blocks = false,
                },
            },
            ["core.norg.completion"] = {
                config = {
                    engine = "nvim-cmp",
                },
            },
            ["core.norg.dirman"] = {
                config = {
                    workspaces = {
                        home = "~/notes",
                    },
                    autodetect = true,
                    autochdir = true,
                },
            },


        }
    }

EOF

colorscheme onedark
