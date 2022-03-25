local pkg_config = require('core/utils').pkg_config

return {
    -- Packer itself
    { 'wbthomason/packer.nvim' },

    {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'octaltree/cmp-look',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'f3fora/cmp-spell',
            'hrsh7th/cmp-emoji',
            'dcampos/nvim-snippy',
        },
        config = pkg_config('cmp'),
    },

    -- Filesystem explorer
    -- {
    --     'nvim-neo-tree/neo-tree.nvim',
    --     branch = "v1.x",
    --     requires = {
    --         'nvim-lua/plenary.nvim',
    --         'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
    --         'MunifTanjim/nui.nvim',
    --     },
    --     config = pkg_config('neotree'),
    -- },
    {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        config = pkg_config('nvimtree'),
    },

    -- Icons & color scheme
    { 'kyazdani42/nvim-web-devicons', config = pkg_config('devicons') },
    -- { 'joshdick/onedark.vim', config = pkg_config('colorscheme') },
    { 'EdenEast/nightfox.nvim', config = pkg_config('nightfox') },

    -- -- Tab line
    -- {
    --     'akinsho/bufferline.nvim',
    --     requires = { 'kyazdani42/nvim-web-devicons' },
    --     config = pkg_config('bufferline'),
    -- },

    -- CMake integration
    { 'cdelledonne/vim-cmake' },

    -- Development
    { 'tpope/vim-dispatch' },
    { 'tpope/vim-surround' },
    { 'tpope/vim-commentary' },
    { 'tpope/vim-rhubarb' },
    { 'tpope/vim-unimpaired' },
    { 'tpope/vim-vinegar' },
    { 'wellle/targets.vim' },

    { 'liuchengxu/vim-which-key' },
    { 'norcalli/nvim-colorizer.lua', config = pkg_config('colorizer') },
    {
        'lewis6991/gitsigns.nvim',
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
    { 'vim-test/vim-test' },
    -- { 'rcarriga/vim-ultest", run = ":UpdateRemotePlugins' },

    {
        'folke/trouble.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = pkg_config('trouble'),
    },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },
        config = pkg_config('telescope'),
    },
    {
        'nvim-telescope/telescope-frecency.nvim',
        requires = { 'tami5/sql.nvim' },
        config = pkg_config('frecency'),
    },
    { 'nvim-telescope/telescope-symbols.nvim' },
    { 'nvim-telescope/telescope-media-files.nvim' },

    -- LSP config
    { 'neovim/nvim-lspconfig', config = pkg_config('lspconfig') },

    -- Better LSP experience
    { 'glepnir/lspsaga.nvim', config = pkg_config('lspsaga') },
    { 'onsails/lspkind-nvim', config = pkg_config('lspkind') },
    { 'sbdchd/neoformat' },
    { 'p00f/nvim-ts-rainbow' },
    { 'gennaro-tedesco/nvim-peekup' },
    { 'ray-x/lsp_signature.nvim' },
    { 'szw/vim-maximizer' },
    { 'dyng/ctrlsf.vim' },
    { 'dbeniamine/cheat.sh-vim' },
    -- { 'wellle/context.vim'},
    -- { 'lukas-reineke/indent-blankline.nvim' },
    -- { 'Yggdroot/indentLine' },
    -- { 'beauwilliams/focus.nvim' },
    -- { 'RRethy/vim-illuminate' },
    { 'kosayoda/nvim-lightbulb', config = pkg_config('lightbulb') },

    -- Snippets
    {
        'dcampos/nvim-snippy',
        requires = { 'dcampos/cmp-snippy' },
        config = pkg_config('snippy'),
    },
    { 'honza/vim-snippets' },
    -- { 'nvim-telescope/telescope-snippets.nvim' },

    -- Lua development
    -- { 'tjdevries/nlua.nvim' },

    -- Better syntax
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = pkg_config('treesitter'),
    },
    { 'nvim-treesitter/playground' },

    -- Dashboard
    { 'glepnir/dashboard-nvim' },

    -- Status line
    {
        'nvim-lualine/lualine.nvim',
        event = "VimEnter",
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = pkg_config('lualine'),
    },

    -- Debugging
    { 'puremourning/vimspector' },
    { 'nvim-telescope/telescope-vimspector.nvim' },

    -- Telescope fzf
    { 'nvim-telescope/telescope-fzy-native.nvim' },

    -- Project
    { 'nvim-telescope/telescope-project.nvim', config = pkg_config('project') },
    { 'airblade/vim-rooter' },
    { 'tpope/vim-projectionist' },

    -- Markdown
    { 'ellisonleao/glow.nvim', run = ':GlowInstall' },
    { 'mzlogin/vim-markdown-toc' },
    { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' },

    -- Development settings
    -- {'editorconfig/editorconfig-vim'},

    -- Note taking
    -- {'vimwiki/vimwiki', branch = 'dev'},
    -- {'blindFS/vim-taskwarrior'},
    -- {'tools-life/taskwiki'},
    -- {'powerman/vim-plugin-AnsiEsc'},

    -- Presentation
    { 'sotte/presenting.vim' },
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
