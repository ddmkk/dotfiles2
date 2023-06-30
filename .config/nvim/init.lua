print('init.lua start!')
-- base
--[[
vim.oは文字列,数値、真偽値を返す
vim.optは[option object]を返す
]]
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- ファイルエンコード自動判別機能
vim.opt.fileencodings = "iso-2022-jp,euc-jp,sjis,utf-8"

-- 改行コード自動認識順番
vim.opt.fileformats = "unix,dos,mac"

vim.opt.clipboard:append{'unnamedplus'}
vim.opt.helplang = "ja", "en"
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.showtabline = 2

-- 不可視文字設定
vim.opt.list = true
vim.opt.listchars = "eol:$,tab:>-,trail:_,nbsp:+"

vim.opt.cursorline = false
vim.opt.cursorcolumn = false
vim.opt.backup = false
vim.opt.undofile = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.autoread = true
vim.opt.showcmd = true
vim.opt.cmdheight = 2
vim.opt.laststatus = 2
vim.opt.ambiwidth = 'double'
vim.opt.autochdir = true
vim.opt.signcolumn = 'yes'
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.wrap = true
vim.opt.winblend = 5
vim.opt.showmatch = true
vim.opt.visualbell = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- GUI Only
vim.opt.guifont = { "HackGen35 Console NF:h11" }
vim.opt.guifontwide = { "HackGen35 Console NF:h11" }

--[[
keymaps
]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set('n', "<F1>", ":e $MYVIMRC<CR>")
vim.keymap.set('n', "<F5>", ":source $MYVIMRC<CR>")

vim.keymap.set('n', "j", "gj")
vim.keymap.set('n', "k", "gk")
vim.keymap.set('n', "gj", "j")
vim.keymap.set('n', "gk", "k")

-- 挿入モードからの離脱
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('i', "<C-C>", "<ESC>")
-- ESC*2でハイライト解除
vim.keymap.set('n', '<ESC><ESC>', ':<C-u>set nohlsearch<CR>')


-- autocmd
-- Remove whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = "*",
  command = ":%s/\\s\\+$//e"
})

-- Don't auto commenting new lines
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o"
})

-- Restore cursor location when file is opened
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = { "*" },
  callback = function()
    vim.api.nvim_exec('silent! normal! g`"zv', false)
  end,
})

--[[
ユーザー定義関数
]]
vim.api.nvim_create_user_command('Here', 'cd %:h', {})

-- plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- utility
  "nvim-lua/plenary.nvim",
  -- color
  "EdenEast/nightfox.nvim",
  -- "folke/tokyonight.nvim",
  -- help
  "vim-jp/vimdoc-ja",
  -- comment
  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end
  },
  -- emmet
  {
    "mattn/emmet-vim",
    lazy = true,
    event = 'InsertEnter',
    config = function()
      vim.g.user_emmet_leader_key='<C-e>'
    end
  },
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require('lualine').setup()
    end
  },
  -- tabs
  {
    "kdheepak/tabline.nvim",
    config = function()
      require('tabline').setup()
    end
  },
  -- indent
  {
    "echasnovski/mini.indentscope",
    config = function()
      require("mini.indentscope").setup({
          symbol = "|"
      })
    end
  },
  -- # インデント箇所で文字に不具合
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   config = function()
  --     require("indent_blankline").setup {
  --       show_current_context = true,
  --       show_current_context_start = true
  --     }
  --   end
  -- },
  --Icon
  {"nvim-tree/nvim-web-devicons", lazy = true},
  -- telescope ファジーファインダー
  {"nvim-telescope/telescope.nvim"},
  {"nvim-telescope/telescope-file-browser.nvim"},
  -- cmp 補完
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-vsnip" },
  { "hrsh7th/vim-vsnip" },
  { "yutkat/cmp-mocword" },
  -- tree-sitter シンタックスハイライト
  { "nvim-treesitter/nvim-treesitter" },
  -- filer
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  },
  --mark
  {
    "chentoast/marks.nvim",
    config = function()
      require'marks'.setup {
        default_mappings = true,
        builtin_marks = { ".", "<", ">", "^" },
      }
    end
  },
  -- stylus
  "vio/vim-stylus",
  -- pug
  "seletskiy/vim-pug",
  -- nunjucks
  "Glench/Vim-jinja2-Syntax"
})

-- emmet
vim.g.user_emmet_leader_key = '<C-e>'
vim.g.user_emmet_settings = {
  variables = {
    lang = 'ja',
  },
  html = {
    comment_type = 'lastonly'
  }
}


-- tabline
vim.keymap.set("n", "<C-Right>", ":bnext<CR>")
vim.keymap.set("n", "<C-Left>", ":bprevious<CR>")


-- telescope-file-browser
local status, telescope = pcall(require, "telescope")
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end
local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close,
        -- バッファを閉じる
        ["<C-d>"] = require('telescope.actions').delete_buffer
      },
      i = {
        -- バッファを閉じる
        ["<C-d>"] = require('telescope.actions').delete_buffer
      }
    }
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["l"] = fb_actions.open, -- @XXX wslの場合はLinuxにxdg-utilsのインストールが必要
          ["/"] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
}

telescope.load_extension("file_browser")
-- feでファイラー起動
vim.keymap.set("n", "<space>fe", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    preview = true,
    initial_mode = "normal",
    layout_config = { height = 30 }
  })
end)
-- fbでバッファ起動
vim.keymap.set("n", "<Leader>fb", builtin.buffers, {})

-- neo-tree
vim.keymap.set("n", "<F9>", ":NeoTreeShowToggle<CR>")


--[[
■補完関連
]]

-- 1. LSP Sever management
require('mason').setup()
require('mason-lspconfig').setup_handlers({ function(server)
  local opt = {
    -- -- Function executed when the LSP server startup
    -- on_attach = function(client, bufnr)
    --   local opts = { noremap=true, silent=true }
    --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    --   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
    -- end,
    capabilities = require('cmp_nvim_lsp').default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  }
  require('lspconfig')[server].setup(opt)
end })

-- 2. build-in LSP function
-- keyboard shortcut
vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
-- Reference highlight
vim.cmd [[
set updatetime=500
highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
augroup lsp_document_highlight
  autocmd!
  autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
  autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
augroup END
]]

-- 3. completion (hrsh7th/nvim-cmp)
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "cmdline" },
    { name = "mocword" },
    { name = "vsnip" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})


-- cmp.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' }
--   }
-- })
-- cmp.setup.cmdline(":", {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = "path" },
--     { name = "cmdline" },
--   },
-- })

-- tree-sitter
require'nvim-treesitter.configs'.setup {
  -- ensure_installed = "all",
  highlight = {
    enable = true, -- syntax hightlightを有効化
    -- 無効化リスト
    disable = {
      'lua',
    },
    indent = {
      enable = true, -- tree-sitterによるインデント
    }
  },
}

-- colorscheme
vim.cmd [[colorscheme nightfox]]
-- vim.cmd [[colorscheme tokyonight]]


-- ime off
-- インサートモード解除時に半角英数に戻す
vim.cmd [[
if executable('zenhan') " neovim-qt
  autocmd InsertLeave * :call system('zenhan 0')
  autocmd CmdlineLeave * :call system('zenhan 0')
else " wsl neovim
	let &shell='/usr/bin/bash --login'
	autocmd InsertLeave * :call system('${zenhan} 0')
	autocmd CmdlineLeave * :call system('${zenhan} 0')
endif
]]

--[[
全角スペースをハイライト表示
]]
vim.api.nvim_create_augroup('extra-whitespace', {})
vim.api.nvim_create_autocmd({'VimEnter', 'WinEnter'}, {
  group = 'extra-whitespace',
  pattern = {'*'},
  command = [[call matchadd('ExtraWhitespace', '[\u200B\u3000]')]]
})
vim.api.nvim_create_autocmd({'ColorScheme'}, {
  group = 'extra-whitespace',
  pattern = {'*'},
  command = [[highlight default ExtraWhitespace ctermbg=202 ctermfg=202 guibg=salmon]]
})

print('end of init.lua!')
