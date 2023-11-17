-- See https://github.com/neovim/nvim-lspconfig

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'x', '<space>a', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>pp', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>pw', '<cmd>lua vim.lsp.buf.formatting()<CR><cmd>write<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'x', '<space>p', '<cmd>lua vim.lsp.buf.range_formatting({})<CR>', opts)
  vim.keymap.set('n', '<space>pp', function() 
    vim.lsp.buf.format { async = true }
  end, { buffer = bufnr })

  vim.keymap.set('n', '<space>w', function()
    vim.lsp.buf.format()
    vim.api.nvim_command('write')
  end, { buffer = bufnr })
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers_with_defaults = {
  'dockerls',
  'gopls',
  'nil_ls',
  'prismals',
  'tsserver',
  'yamlls',
}

local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

for _, lsp in pairs(servers_with_defaults) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig['eslint'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = function(fname)
    -- Split the pattern into two to support nested directories with a package.json
    -- using parent .eslintrc and tsconfig.json
    return util.root_pattern(
      '.eslintrc',
      '.eslintrc.js',
      '.eslintrc.cjs',
      '.eslintrc.yaml',
      '.eslintrc.yml',
      '.eslintrc.json'
    )(fname) or util.root_pattern(
      'package.json',
      '.git'
    )(fname)
  end,
}

require('null-ls').setup {
  on_attach = on_attach
}

vim.g.rustaceanvim = {
  tools = {},

  server = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end,

    settings = {
      ['rust-analyzer'] = {
        check = {
          command = "clippy",
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
          features = "all",
        },
        procMacro = {
          enable = true,
        },
      },
    },
  },

  dap = {},
}

require('trouble').setup {}

vim.keymap.set("n", "<space>xx", "<cmd>TroubleToggle<cr>", opts)
vim.keymap.set("n", "<space>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
vim.keymap.set("n", "<space>xd", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
vim.keymap.set("n", "<space>xl", "<cmd>TroubleToggle loclist<cr>", opts)
vim.keymap.set("n", "<space>xq", "<cmd>TroubleToggle quickfix<cr>", opts)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", opts)
