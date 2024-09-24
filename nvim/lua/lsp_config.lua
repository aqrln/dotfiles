-- neoconf needs to be configured before nvim-lspconfig
-- See https://github.com/folke/neoconf.nvim
require('neoconf').setup {}

-- neodev needs to be configured before nvim-lspconfig too
-- See https://github.com/folke/neodev.nvim
require('neodev').setup {}

-- nvim-lspconfig configuration
-- See https://github.com/neovim/nvim-lspconfig

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

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
  vim.api.nvim_buf_set_keymap(bufnr, 'x', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>llr', '<cmd>LspRestart<CR>', opts)

  vim.keymap.set('n', '<space>lf', function()
    vim.lsp.buf.format { async = true }
  end, { buffer = bufnr, desc = "format buffer" })

  vim.keymap.set('n', '<space>w', function()
    vim.lsp.buf.format()
    vim.api.nvim_command('write')
  end, { buffer = bufnr, desc = "format and save" })

  vim.keymap.set('n', '<space>li', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { buffer = bufnr, desc = "toggle inlay hints" })
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers_with_defaults = {
  'cssls',
  'dockerls',
  'gopls',
  'html',
  'lua_ls',
  'nil_ls',
  'pest_ls',
  'prismals',
  'tailwindcss',
}

local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

for _, lsp in pairs(servers_with_defaults) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.eslint.setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.keymap.set('n', '<space>lef', function()
      vim.api.nvim_command('EslintFixAll')
    end, { buffer = bufnr })
  end,
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
      '.eslintrc.json',
      '.eslint.config.js',
      '.eslint.config.mjs',
      '.eslint.config.cjs',
      '.eslint.config.ts',
      '.eslint.config.mts',
      '.eslint.config.cts'
    )(fname) or util.root_pattern(
      'package.json',
      '.git'
    )(fname)
  end,
  settings = {
    experimental = {
      useFlatConfig = true,
    }
  },
}

require('null-ls').setup {
  on_attach = on_attach
}

lspconfig.jsonls.setup {
  on_attach = on_attach,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}

lspconfig.yamlls.setup {
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}

vim.g.rustaceanvim = {
  tools = {},

  server = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)

      vim.keymap.set("n", "K", function() vim.cmd.RustLsp { 'hover', 'actions' } end, { buffer = bufnr })
      vim.keymap.set("x", "K", function() vim.cmd.RustLsp { 'hover', 'range' } end, { buffer = bufnr })
      vim.keymap.set("n", "<space>e", function() vim.cmd.RustLsp('renderDiagnostic') end, { buffer = bufnr, desc = "diagnostic" })
      vim.keymap.set("n", "<space>E", function() vim.cmd.RustLsp('explainError') end, { buffer = bufnr, desc = "explain error" })
      vim.keymap.set({"n", "x"}, "<space>a", function() vim.cmd.RustLsp('codeAction') end, { buffer = bufnr, desc = "code actions" })

      vim.keymap.set("n", "<space>K", function() vim.cmd.RustLsp("openDocs") end, { buffer = bufnr, desc = "open docs" })
      vim.keymap.set("n", "gp", function() vim.cmd.RustLsp("parentModule") end, { buffer = bufnr, desc = "parent module" })
      vim.keymap.set("n", "gC", function() vim.cmd.RustLsp("openCargo") end, { buffer = bufnr, desc = "open Cargo.toml" })

      vim.keymap.set("n", "<space>mu", function()
        vim.cmd.RustLsp { "moveItem", "up" }
      end, { buffer = bufnr, desc = "move item up" })

      vim.keymap.set("n", "<space>md", function()
        vim.cmd.RustLsp { "moveItem", "down" }
      end, { buffer = bufnr, desc = "move item down" })
    end,

    settings = {
      ['rust-analyzer'] = {
        check = {
          command = "clippy",
          features = "all";
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
          features = "all",
        },
        hover = {
          memoryLayout = {
            niches = true,
          },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  },

  dap = {},
}

local vtsls = require("vtsls")

require("lspconfig.configs").vtsls = vtsls.lspconfig

lspconfig.vtsls.setup {
  on_attach = function (client, bufnr)
    on_attach(client, bufnr)

    vim.keymap.set("n", "gS", function ()
      vim.cmd.VtsExec("goto_source_definition")
    end, { buffer = bufnr, desc = "go to source definition" })

    vim.keymap.set("n", "<space>lo", function()
      vtsls.commands.organize_imports(bufnr)
    end, { buffer = bufnr, desc = "organize imports" })

    vim.keymap.set("n", "<space>lto", function()
      vtsls.commands.organize_imports(bufnr)
    end, { buffer = bufnr, desc = "organize imports" })

    vim.keymap.set("n", "<space>ltf", function()
      vtsls.commands.fix_all(bufnr)
    end, { buffer = bufnr, desc = "fix all" })

    vim.keymap.set("n", "<space>ltr", function()
      vtsls.commands.rename_file(bufnr)
    end, { buffer = bufnr, desc = "rename file" })

    vim.keymap.set("n", "<space>lti", function()
      vtsls.commands.add_missing_imports(bufnr)
    end, { buffer = bufnr, desc = "add missing imports" })

    vim.keymap.set("n", "<space>ltf", function()
      vtsls.commands.file_references(bufnr)
    end, { buffer = bufnr, desc = "find file references" })

    vim.keymap.set("n", "<space>lta", function()
      vtsls.commands.source_actions(bufnr)
    end, { buffer = bufnr, desc = "source actions" })
  end,

  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      }
    },
  },

  root_dir = util.root_pattern("package.json"),

  single_file_support = false,
}

lspconfig.denols.setup({
  on_attach = on_attach,
  root_dir = util.root_pattern("deno.json", "deno.jsonc")
})

require('trouble').setup {}

vim.keymap.set("n", "<space>xx", "<cmd>TroubleToggle<cr>", opts)
vim.keymap.set("n", "<space>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
vim.keymap.set("n", "<space>xd", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
vim.keymap.set("n", "<space>xl", "<cmd>TroubleToggle loclist<cr>", opts)
vim.keymap.set("n", "<space>xq", "<cmd>TroubleToggle quickfix<cr>", opts)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", opts)
