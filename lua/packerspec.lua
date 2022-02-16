local pkg_config = require('utils').pkg_config

local M = {
    {
        -- Packer itself
        {'wbthomason/packer.nvim'}, -- Firenvim
        {
            'glacambre/firenvim',
            run = function() vim.fn['firenvim#install'](0) end
        }, -- Completion
        {
            'hrsh7th/nvim-cmp',
            requires = {'hrsh7th/cmp-nvim-lsp'},
            config = pkg_config('cmp')
        }, -- Icons & color scheme
        {'kyazdani42/nvim-web-devicons', config = pkg_config('devicons')},
        {'joshdick/onedark.vim', config = pkg_config('colorscheme')},

        -- CMake integration
        {'cdelledonne/vim-cmake'}, -- Development
        {'tpope/vim-dispatch'},
        {'tpope/vim-fugitive', config = pkg_config('fugitive')},
        {'tpope/vim-surround'}, {'tpope/vim-commentary'}, {'tpope/vim-rhubarb'},
        {'tpope/vim-unimpaired'}, {'tpope/vim-vinegar'}, {'wellle/targets.vim'},
        {'liuchengxu/vim-which-key'},
        {'norcalli/nvim-colorizer.lua', config = pkg_config('colorizer')}, {
            'lewis6991/gitsigns.nvim',
            config = function() require('gitsigns').setup() end
        },
        {
            'TimUntersberger/neogit',
            config = function() require('neogit').setup() end
        }, -- { 'unblevable/quick-scope' },
        -- { 'christoomey/vim-tmux-navigator' },
        -- { 'mhinz/vim-signify' },
        -- { 'radenling/vim-dispatch-neovim' },
        -- { 'phaazon/hop.nvim' },
        -- Testing
        {'vim-test/vim-test'},
        -- { 'rcarriga/vim-ultest", run = ":UpdateRemotePlugins' },

        -- Telescope
        {'nvim-lua/plenary.nvim'}, {'nvim-lua/popup.nvim'},
        {'nvim-telescope/telescope.nvim', config = pkg_config('telescope')}, {
            'nvim-telescope/telescope-frecency.nvim',
            requires = {'tami5/sql.nvim'},
            config = function()
                require('telescope').load_extension('frecency')
            end
        }, {'nvim-telescope/telescope-symbols.nvim'},
        -- { 'nvim-telescope/telescope-arecibo.nvim', rocks = {"openssl", "lua-http-parser"} },

        -- { 'nvim-telescope/telescope-media-files.nvim' },
        -- { 'nvim-telescope/telescope-packer.nvim ' },

        -- LSP config
        {'neovim/nvim-lspconfig'}, -- { 'kabouzeid/nvim-lspinstall'},
        -- Better LSP experience
        {'glepnir/lspsaga.nvim', config = pkg_config('lspsaga')},
        {'onsails/lspkind-nvim'}, {'sbdchd/neoformat'},
        {'p00f/nvim-ts-rainbow'}, {'gennaro-tedesco/nvim-peekup'},
        {'ray-x/lsp_signature.nvim'}, {'szw/vim-maximizer'},
        {'dyng/ctrlsf.vim'}, {'dbeniamine/cheat.sh-vim'},
        {'kevinhwang91/nvim-bqf'}, -- { 'wellle/context.vim'},
        -- { 'lukas-reineke/indent-blankline.nvim' },
        -- { 'Yggdroot/indentLine' },
        -- { 'beauwilliams/focus.nvim' },
        -- { 'RRethy/vim-illuminate' },
        -- { 'kosayoda/nvim-lightbulb' },
        -- Snippets
        {
            'dcampos/nvim-snippy',
            requires = {'dcampos/cmp-snippy'},
            config = pkg_config('snippy')
        }, {'honza/vim-snippets'},
        -- { 'nvim-telescope/telescope-snippets.nvim' },

        -- Lua development
        -- { 'tjdevries/nlua.nvim' },

        -- Better syntax
        {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = pkg_config('treesitter')
        }, {'nvim-treesitter/playground'}, -- Dashboard
        {'glepnir/dashboard-nvim'}, -- Status line
        {
            'nvim-lualine/lualine.nvim',
            event = "VimEnter",
            config = function() require('lualine').setup() end,
            requires = {'kyazdani42/nvim-web-devicons', opt = true}
        }, -- Debugging
        {'puremourning/vimspector'},
        {'nvim-telescope/telescope-vimspector.nvim'}, -- Telescope fzf
        {'nvim-telescope/telescope-fzy-native.nvim'}, -- Project
        {
            'nvim-telescope/telescope-project.nvim',
            config = pkg_config('project')
        }, {'airblade/vim-rooter'}, {'tpope/vim-projectionist'}, -- Markdown
        {'npxbr/glow.nvim', run = ':GlowInstall'}, {'mzlogin/vim-markdown-toc'},
        {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'},

        -- Development settings
        -- {'editorconfig/editorconfig-vim'},

        -- Note taking
        -- {'vimwiki/vimwiki', branch = 'dev'},
        -- {'blindFS/vim-taskwarrior'},
        -- {'tools-life/taskwiki'},
        -- {'powerman/vim-plugin-AnsiEsc'},

        -- Presentation
        {'sotte/presenting.vim'}
        -- {'vim-pandoc/vim-pandoc'},
        -- {'vim-pandoc/vim-pandoc-syntax'},

        -- Project mgmt
        -- { 'vim-ctrlspace/vim-ctrlspace' },

        -- OSC 52 yank
        -- { 'ojroques/vim-oscyank' },

        -- Jupyter Vim
        -- { 'jupyter-vim/jupyter-vim' },

        -- Scratch pad
        -- { 'metakirby5/codi.vim' },

        -- Latex
        -- { 'lervag/vimtex' },

        -- Floaterm
        -- { 'voldikss/vim-floaterm' },

        -- Neoterm
        -- { 'kassio/neoterm' },

        -- Better terminal
        -- { 'nikvdp/neomux' },
    }
}

-- Packer options itself
M['config'] = {
    -- ensure_dependencies  = true, -- Should packer install plugin dependencies?
    -- package_root         = join_paths(stdpath('data'), 'site', 'pack'),
    -- compile_path         = join_paths(stdpath 'config', 'plugin', 'packer_compiled.lua'),
    -- plugin_package       = 'packer', -- The default package for plugins
    -- max_jobs             = nil, -- Limit the number of simultaneous jobs. nil means no limit
    -- auto_clean           = true, -- During sync(), remove unused plugins
    -- disable_commands     = false, -- Disable creating commands
    -- opt_default          = false, -- Default to using opt (as opposed to start) plugins
    -- transitive_opt       = true, -- Make dependencies of opt plugins also opt by default
    -- transitive_disable   = true, -- Automatically disable dependencies of disabled plugins
    -- git                  = {
    --     cmd         = 'git', -- The base command for git operations
    --     subcommands = { -- Format strings for git subcommands
    --         update         = 'pull --ff-only --progress --rebase=false',
    --         install        = 'clone --depth %i --no-single-branch --progress',
    --         fetch          = 'fetch --depth 999999 --progress',
    --         checkout       = 'checkout %s --',
    --         update_branch  = 'merge --ff-only @{u}',
    --         current_branch = 'branch --show-current',
    --         diff           = 'log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
    --         diff_fmt       = '%%h %%s (%%cr)',
    --         get_rev        = 'rev-parse --short HEAD',
    --         get_msg        = 'log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
    --         submodules     = 'submodule update --init --recursive --progress'
    --     },
    --     depth              = 1, -- Git clone depth
    --     clone_timeout      = 60, -- Timeout, in seconds, for git clones
    --     default_url_format = 'https://github.com/%s' -- Lua format string used for "aaa/bbb" style plugins
    -- },
    display = {
        -- non_interactive = false, -- If true, disable display windows for all operations
        open_fn = require('packer.util').float -- An optional function to open a window for packer's display
        -- open_cmd        = '65vnew \\[packer\\]', -- An optional command to open a window for packer's display
        -- working_sym     = '⟳', -- The symbol for a plugin being installed/updated
        -- error_sym       = '✗', -- The symbol for a plugin with an error in installation/updating
        -- done_sym        = '✓', -- The symbol for a plugin which has completed installation/updating
        -- removed_sym     = '-', -- The symbol for an unused plugin which was removed
        -- moved_sym       = '→', -- The symbol for a plugin which was moved (e.g. from opt to start)
        -- header_sym      = '━', -- The symbol for the header line in packer's display
        -- show_all_info   = true, -- Should packer show all update details automatically?
        -- prompt_border   = 'double', -- Border style of prompt popups.
        -- keybindings     = { -- Keybindings for the display window
        --     quit          = 'q',
        --     toggle_info   = '<CR>',
        --     diff          = 'd',
        --     prompt_revert = 'r',
        -- }
    }
    -- luarocks             = {
    --     python_cmd = 'python' -- Set the python command to use for running hererocks
    -- },
    -- log                  = { level = 'warn' }, -- The default print log level. One of: "trace", "debug", "info", "warn", "error", "fatal".
    -- profile              = {
    --     enable    = false,
    --     threshold = 1, -- integer in milliseconds, plugins which load faster than this won't be shown in profile output
    -- }
}

return M
