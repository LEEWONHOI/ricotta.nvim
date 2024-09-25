return {
  -- Wq로도 파일 저장 가능
  vim.api.nvim_create_user_command('Wq', 'wq', {}),

  -- Python
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
      vim.opt_local.colorcolumn = '80' -- Python에서는 80열을 넘어가면 줄 표시
      vim.cmd [[ highlight ColorColumn ctermbg=0 guibg=lightgrey ]] -- 색상 변경
    end,
  }),

  -- Go
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'go',
    callback = function()
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.softtabstop = 4
      vim.opt_local.expandtab = false -- Go에서는 탭을 사용하는 것이 일반적입니다.
    end,
  }),
}
