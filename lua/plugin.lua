local pkg_config = require('core/utils').pkg_config

return {
    -- Packer itself
    { 'wbthomason/packer.nvim' },

    -- Optimiser
    { "lewis6991/impatient.nvim" },

    -- Lua functions
    { "nvim-lua/plenary.nvim", module = "plenary" },

    -- Popup API
    { "nvim-lua/popup.nvim" },

    -- Neovim UI Enhancer
    { "MunifTanjim/nui.nvim", module = "nui" },

    -- Notification Enhancer
    { "rcarriga/nvim-notify", config = pkg_config('notify') },

    -- Indentation
    {
        "lukas-reineke/indent-blankline.nvim",
        config = pkg_config('indent/blankline'),
    },

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
        after = { "LuaSnip", "nvim-lspconfig" },
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
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
    { 'EdenEast/nightfox.nvim', config = pkg_config('nightfox') },

    -- Tab line
    {
        'akinsho/bufferline.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = pkg_config('bufferline'),
    },

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

    -- LSP outliner
    {
        "stevearc/aerial.nvim",
        after = "nvim-lspconfig",
        module = "aerial",
        cmd = { "AerialToggle", "AerialOpen", "AerialInfo" },
        config = pkg_config('aerial'),
    },

    -- Better LSP experience
    -- { 'glepnir/lspsaga.nvim', config = pkg_config('lspsaga') },
    -- { 'kosayoda/nvim-lightbulb', config = pkg_config('lightbulb') },

    -- Better syntax
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = pkg_config('treesitter'),
    },

    { 'nvim-treesitter/playground', after = 'nvim-treesitter' },

    -- Parenthesis highlighting
    { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },

    -- Autoclose tags
    { "windwp/nvim-ts-autotag", after = "nvim-treesitter" },

    -- Context based commenting
    { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },

    -- Dashboard
    { 'glepnir/dashboard-nvim', config = pkg_config('dashboard') },

    -- Status line
    {
        "feline-nvim/feline.nvim",
        after = "nvim-web-devicons",
        config = pkg_config('feline'),
    },

    -- Project
    {
        'nvim-telescope/telescope-project.nvim',
        after = 'telescope.nvim',
        config = function() require("telescope").load_extension "project" end,
    },

    -- Markdown
    -- { 'ellisonleao/glow.nvim', run = ':GlowInstall' },
    -- { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' },

    -- Note taking
    { 'nvim-orgmode/orgmode', ft = "org", config = pkg_config('orgmode') },

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

    -- Neoterm
    -- { 'kassio/neoterm' },

    -- Better terminal
    -- { 'nikvdp/neomux' },

    -- Commenting
    {
        "numToStr/Comment.nvim",
        event = { "BufRead", "BufNewFile" },
        config = pkg_config('comment'),
    },
}
