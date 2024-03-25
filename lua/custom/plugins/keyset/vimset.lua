return {
  -- Wq로도 파일 저장 가능
  vim.api.nvim_create_user_command('Wq', 'wq', {}),

  -- Go 들여쓰기 4칸으로 조절
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
