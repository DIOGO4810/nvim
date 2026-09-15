return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'

    require('mason-null-ls').setup {
      ensure_installed = { 'shfmt', 'checkmake', 'clang_format', 'rustfmt' },
      automatic_installation = true,
    }

    null_ls.setup {
      sources = {
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.shfmt.with { args = { '-i', '4' } },
        null_ls.builtins.formatting.terraform_fmt,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.rustfmt,
      },
    }

    -- Criar o grupo para não duplicar autocomandos
    local augroup = vim.api.nvim_create_augroup('LspFormatting', { clear = true })

    -- O Autocmd simplificado e direto (Sem filtros de nome que falham)
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      pattern = '*',
      callback = function(args)
        -- Corre exatamente o comando que tu usas manualmente e que funciona!
        vim.lsp.buf.format {
          bufnr = args.buf,
          async = false,
        }
      end,
    })
  end,
}
