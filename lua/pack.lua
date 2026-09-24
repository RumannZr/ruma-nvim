vim.pack.add({
    "https://github.com/rose-pine/neovim",
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/rafamadriz/friendly-snippets",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/akinsho/toggleterm.nvim",
    "https://github.com/kdheepak/lazygit.nvim",
})

-- rose-pine settings
require("rose-pine").setup({
    styles = {
        transparency = true,
    },
})

-- toggleterm setup

require("toggleterm").setup({
    size = 20,
    open_mapping = [[<c-\>]],
    direction = "float",
    float_opts = {
        border = "curved",
    },
})

-- lazygit settings

vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", {desc = "Open lazygit panel"})

-- mini-files settings

local MiniFiles = require("mini.files")
MiniFiles.setup({
    mappings = {
        go_in = "<CR>",
        go_in_plus = "L",
        go_out = "_",
        go_out_plus = "H",
    },
})

vim.keymap.set("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })
vim.keymap.set("n", "<leader>-", function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    MiniFiles.reveal_cwd()
end, { desc = "Toggle into currently opened file" })

-- mini-autopairs settings
require("mini.pairs").setup({})

-- mini-notify settings
require("mini.notify").setup({
    -- only show messages
    content = {
        format = function(notif)
            return notif.msg
        end,
    },
})

--- mini-cmdline settings
require("mini.cmdline").setup({
    autocorrect = { enable = false }
})

--- mini-surround settings
require("mini.surround").setup()
-- Default Keymaps
-- | `sa` | Add surrounding or Direct with 'saiw' |
-- | `sd` | Delete surrounding |
-- | `sr` | Replace surrounding |
-- | `sf` | Find surrounding (right) |
-- | `sF` | Find surrounding (left) |
-- | `sh` | Highlight surrounding |
-- | `sn` | Update n_lines |
-- | `l` / `n` | as suffix for prev/next |

-- mini-picker settings

local MiniPick = require("mini.pick")
local MiniExtra = require("mini.extra")
MiniPick.setup()
MiniExtra.setup()

vim.keymap.set("n", "<leader>pf", function() MiniPick.builtin.files() end, { desc = "Mini File Picker" })
vim.keymap.set("n", "<leader>ps", function() MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") }) end,
    { desc = "Grep word/Search word" })
vim.keymap.set("n", "<leader>vh", function() MiniPick.builtin.help() end, { desc = "Mini Help" })

vim.keymap.set("n", "<leader>xx", function() MiniExtra.pickers.diagnostic() end, { desc = "Mini Picker Diagnostics" })
vim.keymap.set("n", "<leader>pk", function() MiniExtra.pickers.keymaps() end, { desc = 'Search keymaps' })

-- mini.complitions

local MiniComp = require("mini.completion")
MiniComp.setup({
    lsp_completion = {
        auto_setup = true,
        process_items = function(items, base)
            return MiniComp.default_process_items(items, base, {
                filesort = "fuzzy",
            })
        end,
    }
})

-- mini-snippets
local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
    snippets = {
        MiniSnippets.gen_loader.from_lang(), -- loads friendly-snippets
    },
})
MiniSnippets.start_lsp_server({ match = false })

--- mini-diff and fugitive settings

local MiniDiff = require("mini.diff")
MiniDiff.setup({
    source = MiniDiff.gen_source.git({ index = false }),
})

vim.keymap.set("n", "<leader>gg", "<cmd>tabnew | Git | only<cr>", { desc = "Fugitive Full Page New Tab" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { desc = "Git diff split", })

-- nvim treesitter settings
require("treesitter")

-- lsp settings
require("lsp")
