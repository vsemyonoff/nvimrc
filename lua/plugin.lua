local pkg_config = require('core/utils').pkg_config

return {
    -- Packer itself
    { 'wbthomason/packer.nvim' },

    -- Optimiser
    { "lewis6991/impatient.nvim" },

    -- Lua functions
    { "nvim-lua/plenary.nvim" },

    -- Popup API
    { "nvim-lua/popup.nvim" },

    -- Notification Enhancer
    { "rcarriga/nvim-notify", config = pkg_config('notify') },

    -- Neovim UI Enhancer
    { "MunifTanjim/nui.nvim", module = "nui" },

    -- Indent detection
    {
        "Darazaki/indent-o-matic",
        event = "BufRead",
        config = pkg_config('indent/autosize'),
    },

    -- Snippets
    {
        'L3MON4D3/LuaSnip',
        requires = { 'rafamadriz/friendly-snippets' },
        config = pkg_config('luasnip'),
    },

    -- Completion engine
    {
        'hrsh7th/nvim-cmp',
        after = 'LuaSnip',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-path',
            'onsails/lspkind-nvim',
            'saadparwaiz1/cmp_luasnip',
        },
        config = pkg_config('cmp'),
    },

    -- Filesystem explorer
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = "v2.x",
        requires = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
            {
                -- only needed if you want to use the "open_window_picker" command
                's1n7ax/nvim-window-picker',
                tag = "1.*",
                config = pkg_config('picker'),
            },
        },
        config = pkg_config('neotree'),
    },

    -- Icons & color scheme
    { 'kyazdani42/nvim-web-devicons', config = pkg_config('devicons') },
    { 'norcalli/nvim-colorizer.lua', config = pkg_config('colorizer') },
    { 'EdenEast/nightfox.nvim', config = pkg_config('colorscheme') },

    -- Tab line
    {
        'akinsho/bufferline.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = pkg_config('bufferline'),
    },

    -- Development
    -- { 'tpope/vim-dispatch' },
    -- { 'tpope/vim-surround' },
    -- { 'tpope/vim-commentary' },
    -- { 'tpope/vim-rhubarb' },
    -- { 'tpope/vim-unimpaired' },
    -- { 'tpope/vim-vinegar' },
    -- { 'wellle/targets.vim' },

    { "folke/which-key.nvim", config = pkg_config('whichkey') },

    -- Git integration
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufRead", "BufNewFile" },
        requires = { 'nvim-lua/plenary.nvim' },
        config = pkg_config('gitsigns'),
    },
    {
        'TimUntersberger/neogit',
        requires = { 'nvim-lua/plenary.nvim' },
        config = pkg_config('neogit'),
    },

    -- { 'unblevable/quick-scope' },
    -- { 'christoomey/vim-tmux-navigator' },
    -- { 'mhinz/vim-signify' },
    -- { 'radenling/vim-dispatch-neovim' },
    -- { 'phaazon/hop.nvim' },

    -- Testing
    -- { 'vim-test/vim-test' },
    -- { 'rcarriga/vim-ultest", run = ":UpdateRemotePlugins' },

    {
        'folke/trouble.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = pkg_config('trouble'),
    },

    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        after = "which-key.nvim",
        config = pkg_config('telescope'),
    },

    -- Fuzzy finder syntax support
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        after = "telescope.nvim",
        run = "make",
        config = function() require("telescope").load_extension "fzf" end,
    },

    {
        'nvim-telescope/telescope-frecency.nvim',
        after = 'telescope.nvim',
        requires = { 'tami5/sql.nvim' },
        config = function() require("telescope").load_extension "frecency" end,
    },

    -- LSP config
    { 'neovim/nvim-lspconfig', event = "VimEnter" },

    -- LSP manager
    {
        'williamboman/nvim-lsp-installer',
        requires = 'neovim/nvim-lspconfig',
        config = pkg_config('lsp'),
    },

    -- LSP symbols
    {
        "stevearc/aerial.nvim",
        after = "nvim-lspconfig",
        module = "aerial",
        cmd = { "AerialToggle", "AerialOpen", "AerialInfo" },
        config = pkg_config('aerial'),
    },

    -- Better LSP experience
    -- { 'glepnir/lspsaga.nvim', config = pkg_config('lspsaga') },
    -- { 'sbdchd/neoformat' },
    -- { 'gennaro-tedesco/nvim-peekup' },
    -- { 'szw/vim-maximizer' },
    -- { 'dyng/ctrlsf.vim' },
    -- { 'dbeniamine/cheat.sh-vim' },
    -- { 'wellle/context.vim'},
    -- { 'lukas-reineke/indent-blankline.nvim' },
    -- { 'Yggdroot/indentLine' },
    -- { 'beauwilliams/focus.nvim' },
    -- { 'RRethy/vim-illuminate' },
    -- { 'kosayoda/nvim-lightbulb', config = pkg_config('lightbulb') },

    -- { 'honza/vim-snippets' },
    -- { 'nvim-telescope/telescope-snippets.nvim' },

    -- Lua development
    -- { 'tjdevries/nlua.nvim' },

    -- Parenthesis highlighting
    { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },

    -- Autoclose tags
    { "windwp/nvim-ts-autotag", after = "nvim-treesitter" },

    -- Context based commenting
    { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },

    -- Better syntax
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = pkg_config('treesitter'),
    },
    { 'nvim-treesitter/playground', after = 'nvim-treesitter' },

    -- Dashboard
    { 'glepnir/dashboard-nvim', config = pkg_config('dashboard') },

    -- Status line
    {
        'nvim-lualine/lualine.nvim',
        event = "VimEnter",
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = pkg_config('lualine'),
    },

    -- Debugging
    -- { 'puremourning/vimspector' },
    -- { 'nvim-telescope/telescope-vimspector.nvim' },

    -- Project
    {
        'nvim-telescope/telescope-project.nvim',
        after = 'telescope.nvim',
        config = function() require("telescope").load_extension "project" end,
    },
    -- { 'airblade/vim-rooter' },
    -- { 'tpope/vim-projectionist' },

    -- Markdown
    -- { 'ellisonleao/glow.nvim', run = ':GlowInstall' },
    -- { 'mzlogin/vim-markdown-toc' },
    -- { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' },

    -- Development settings
    -- {'editorconfig/editorconfig-vim'},

    -- Note taking
    -- {'vimwiki/vimwiki', branch = 'dev'},
    -- {'blindFS/vim-taskwarrior'},
    -- {'tools-life/taskwiki'},
    -- {'powerman/vim-plugin-AnsiEsc'},

    -- Presentation
    -- { 'sotte/presenting.vim' },
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

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        after = "nvim-cmp",
        event = "InsertEnter",
        config = pkg_config('autopairs'),
    },

    -- Terminal
    {
        "akinsho/nvim-toggleterm.lua",
        cmd = "ToggleTerm",
        module = { "toggleterm", "toggleterm.terminal" },
        config = pkg_config('toggleterm'),
    },

    -- Indentation
    {
        "lukas-reineke/indent-blankline.nvim",
        config = pkg_config('indent/blankline'),
    },

    -- Commenting
    {
        "numToStr/Comment.nvim",
        event = { "BufRead", "BufNewFile" },
        config = pkg_config('comment'),
    },
}
