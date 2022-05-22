local pkg_config = require('core/utils').pkg_config

return {
    --
    -- Packer itself
    --
    { 'wbthomason/packer.nvim' },

    --
    -- Common libraries
    --
    { -- Optimiser
        "lewis6991/impatient.nvim",
    },
    { -- Lua functions
        "nvim-lua/plenary.nvim",
        module = "plenary",
    },
    { -- Popup API
        "nvim-lua/popup.nvim",
    },
    { -- Neovim UI Enhancer
        "MunifTanjim/nui.nvim",
        module = "nui",
    },
    { -- Notification Enhancer
        "rcarriga/nvim-notify",
        config = pkg_config('notify'),
    },
    { -- Better buffer closing
        'famiu/bufdelete.nvim',
        cmd = { "Bdelete", "Bwipeout" },
    },

    --
    -- Indent
    --
    { -- Indentation markers
        "lukas-reineke/indent-blankline.nvim",
        config = pkg_config('indent/blankline'),
    },
    { -- Indent size detection
        "Darazaki/indent-o-matic",
        event = "BufRead",
        config = pkg_config('indent/autosize'),
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = pkg_config('treesitter'),
    },
    { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
    { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
    { "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
    { 'nvim-treesitter/playground', after = 'nvim-treesitter' },

    --
    -- Language Server Protocol support
    --
    { -- Outliner
        'stevearc/aerial.nvim',
        after = "nvim-treesitter",
        module = "aerial",
        cmd = { "AerialToggle", "AerialOpen", "AerialInfo" },
        config = pkg_config('aerial'),
    },
    { -- Confuguration
        'neovim/nvim-lspconfig',
        after = { "aerial.nvim", "nvim-treesitter" },
        event = "VimEnter",
    },
    { -- Servers manager
        'williamboman/nvim-lsp-installer',
        requires = { 'neovim/nvim-lspconfig' },
        config = pkg_config('lsp'),
    },
    { -- Errors pane
        'folke/trouble.nvim',
        cmd = "TroubleToggle",
        requires = { 'neovim/nvim-lspconfig', 'kyazdani42/nvim-web-devicons' },
        config = pkg_config('trouble'),
    },
    -- { 'glepnir/lspsaga.nvim', config = pkg_config('lspsaga') },
    -- { 'kosayoda/nvim-lightbulb', config = pkg_config('lightbulb') },

    --
    -- Snippets
    --
    {
        'L3MON4D3/LuaSnip',
        requires = { 'rafamadriz/friendly-snippets' },
        config = pkg_config('luasnip'),
    },

    --
    -- Completion engine
    --
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

    --
    -- Input helpers
    --
    { -- Autopairs
        "windwp/nvim-autopairs",
        after = "nvim-cmp",
        event = "InsertEnter",
        config = pkg_config('autopairs'),
    },
    { -- Commenting
        "numToStr/Comment.nvim",
        event = { "BufRead", "BufNewFile" },
        config = pkg_config('comment'),
    },

    --
    -- UI
    --
    { -- Explorer
        'nvim-neo-tree/neo-tree.nvim',
        branch = "v2.x",
        cmd = "Neotree",
        module = { "neo-tree", "neo-tree/command" },
        requires = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        setup = function() vim.g.neo_tree_remove_legacy_commands = true end,
        config = pkg_config('neotree'),
    },
    { -- Theme
        'EdenEast/nightfox.nvim',
        config = pkg_config('nightfox'),
    },
    { -- Icons
        'kyazdani42/nvim-web-devicons',
        config = pkg_config('devicons'),
    },
    { -- Highlight color codes
        'norcalli/nvim-colorizer.lua',
        config = pkg_config('colorizer'),
    },
    { -- Tab line
        'akinsho/bufferline.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = pkg_config('bufferline'),
    },
    { -- Dashboard
        'glepnir/dashboard-nvim',
        config = pkg_config('dashboard'),
    },
    { -- Status line
        "feline-nvim/feline.nvim",
        after = "nvim-web-devicons",
        config = pkg_config('feline'),
    },

    --
    -- Mappings helper
    --
    { "folke/which-key.nvim", config = pkg_config('whichkey') },

    --
    -- Telescope
    --
    {
        "nvim-telescope/telescope.nvim",
        after = "which-key.nvim",
        config = pkg_config('telescope'),
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        after = "telescope.nvim",
        run = "make",
        config = function() require("telescope").load_extension "fzf" end,
    },
    {
        'nvim-telescope/telescope-frecency.nvim',
        after = "telescope.nvim",
        requires = { 'tami5/sql.nvim' },
        config = function() require("telescope").load_extension "frecency" end,
    },

    --
    -- Git integration
    --
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufRead", "BufNewFile" },
        requires = { 'nvim-lua/plenary.nvim' },
        config = pkg_config('gitsigns'),
    },
    {
        'TimUntersberger/neogit',
        cmd = "Neogit",
        requires = { 'nvim-lua/plenary.nvim' },
        config = pkg_config('neogit'),
    },

    --
    -- Project helper
    --
    {
        'ahmedkhalf/project.nvim',
        after = { "nvim-lspconfig", "telescope.nvim" },
        config = pkg_config('project'),
    },

    --
    -- Terminal
    --
    {
        "akinsho/nvim-toggleterm.lua",
        cmd = "ToggleTerm",
        module = { "toggleterm", "toggleterm.terminal" },
        config = pkg_config('toggleterm'),
    },
    -- { -- Neoterm
    --     'kassio/neoterm',
    -- },
    -- { -- Better terminal
    --     'nikvdp/neomux',
    -- },

    --
    -- Different modes enhancements
    --
    { -- Note taking
        'nvim-orgmode/orgmode',
        ft = "org",
        config = pkg_config('orgmode'),
    },
    -- { 'ellisonleao/glow.nvim', run = ':GlowInstall' },
    -- { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' },
}
