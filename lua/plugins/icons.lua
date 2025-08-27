return {
  -- Ícones para ficheiros e linguagens
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },

  -- Exemplo: file explorer com ícones
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- <- aqui
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('neo-tree').setup {
        filesystem = {
          filtered_items = {
            visible = true, -- mostra ficheiros ocultos
          },
        },
      }
    end,
  },
}
