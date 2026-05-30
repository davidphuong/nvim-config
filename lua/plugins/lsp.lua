-- =============================================================================
-- plugins/lsp.lua — LSP + Mason
-- =============================================================================
-- Mason installs and manages language server binaries.
-- mason-lspconfig bridges Mason with Neovim's native LSP client.
-- Neovim 0.11+ has a built-in LSP client — no nvim-lspconfig needed for setup.
--
-- Language servers installed:
--   - bashls       — bash (requires Node.js)
--   - yamlls       — YAML (requires Node.js)
--   - dockerls     — Dockerfile (requires Node.js)
--   - ansiblels    — Ansible (requires Python/pip)
--
-- Commands:
--   :Mason         — open Mason UI to manage servers
--   :MasonInstall  — install a server manually
--   :LspInfo       — show active LSP servers for current buffer
--
-- Keymaps (active when LSP attaches to a buffer):
--   gd        — go to definition
--   gr        — go to references
--   K         — hover documentation
--   <leader>rn — rename symbol
--   <leader>ca — code action
-- =============================================================================

return {
  {
    "mason-org/mason.nvim",
    version = "v2.3.0",      -- pinned version — change deliberately when upgrading
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig", -- needed in runtimepath for server configs
    },
    config = function()
      require("mason-lspconfig").setup({
        -- Automatically install these servers if not already installed
        ensure_installed = {
          "bashls",     -- bash
          "yamlls",     -- yaml
          "dockerls",   -- dockerfile
          "ansiblels",  -- ansible
        },
        -- Automatically enable installed servers via vim.lsp.enable()
        automatic_enable = true,
      })

      -- Server-specific configuration using Neovim's native vim.lsp.config()
      -- These are applied before the servers start

      -- YAML: enable kubernetes schema validation
      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            schemas = {
              kubernetes = "*.yaml",
            },
            validate = true,
          },
        },
      })

      -- Ansible: tell the server which files are ansible playbooks
      vim.lsp.config("ansiblels", {
        settings = {
          ansible = {
            ansible = {
              path = "ansible",
            },
            executionEnvironment = {
              enabled = false,
            },
          },
        },
      })

      -- Keymaps — only set when an LSP attaches to a buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = vim.keymap.set
          local buf = event.buf

          map("n", "gd", vim.lsp.buf.definition,     { buffer = buf, desc = "LSP: go to definition" })
          map("n", "gr", vim.lsp.buf.references,      { buffer = buf, desc = "LSP: go to references" })
          map("n", "K",  vim.lsp.buf.hover,           { buffer = buf, desc = "LSP: hover documentation" })
          map("n", "<leader>rn", vim.lsp.buf.rename,  { buffer = buf, desc = "LSP: rename symbol" })
          map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buf, desc = "LSP: code action" })
        end,
        desc = "Set LSP keymaps on attach",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",  -- needed in runtimepath by mason-lspconfig
    lazy = true,              -- don't load directly — mason-lspconfig uses it
  },
}
