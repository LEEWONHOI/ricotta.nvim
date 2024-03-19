-- gblame 설치
return {
  'tpope/vim-fugitive',
  config = function()
    vim.api.nvim_create_user_command('Gblame', 'Git blame', {})
    --    vim.keymap.set('n', 'gblame', ':Git blame<CR>', { noremap = true, silent = true })
  end,
}
