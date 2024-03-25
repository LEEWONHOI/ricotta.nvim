-- 리팩토링 기능
-- https://github.com/ThePrimeagen/refactoring.nvim?tab=readme-ov-file
return {
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('refactoring').setup {
        prompt_func_return_type = {
          go = true,
          java = false,

          cpp = false,
          c = true,
          h = false,
          hpp = false,
          cxx = false,
        },
        prompt_func_param_type = {
          go = true,
          java = false,

          cpp = false,
          c = true,
          h = false,
          hpp = false,
          cxx = false,
        },
        --        extract_var_statements = {
        --          go = '%s := %s // poggers',
        --        },

        printf_statements = {},
        print_var_statements = {},
        show_success_message = false, -- shows a message with information about the refactor on success
        -- i.e. [Refactor] Inlined 3 variable occurrences
      }
      require('telescope').load_extension 'refactoring'

      vim.keymap.set({ 'n', 'x' }, '<leader>ff', function()
        require('telescope').extensions.refactoring.refactors()
      end)
      -- 비주얼 모드에서 사용자가 선택한 코드 블록을 함수나 메서드로 추출하는 리팩토링 명령을 실행
      vim.keymap.set('x', '<leader>fe', ':Refactor extract ')
      -- 비주얼 모드에서 선택한 코드 블록을 새로운 파일로 추출하는 리팩토링 명령을 실행
      vim.keymap.set('x', '<leader>ft', ':Refactor extract_to_file ')
      -- 비주얼 모드에서 선택한 표현식을 새로운 변수로 추출하는 리팩토링 명령을 실행
      vim.keymap.set('x', '<leader>fv', ':Refactor extract_var ')

      -- 일반, 비주얼 모드에서 사용자가 선택한 변수의 모든 인스턴스를 해당 변수의 값을 가진 직접적인 표현으로 대체하는 리팩토링 명령을 실행
      vim.keymap.set({ 'n', 'x' }, '<leader>fi', ':Refactor inline_var')
      -- 일반 모드에서, 선택된 함수의 모든 호출을 그 함수의 본문으로 대체하는 리팩토링 명령을 실행
      vim.keymap.set('n', '<leader>fI', ':Refactor inline_func')
      -- 일반 모드에서, 현재 커서 위치에 있는 코드 블록(예: 함수 본문, 조건문 등)을 새로운 함수나 메서드로 추출하는 리팩토링 명령을 실행
      vim.keymap.set('n', '<leader>fb', ':Refactor extract_block')
      -- 일반 모드에서, 현재 커서 위치에 있는 코드 블록을 새로운 파일로 추출하는 리팩토링 명령을 실행
      vim.keymap.set('n', '<leader>fbf', ':Refactor extract_block_to_file')
      -- load refactoring Telescope extension
      -- You can also use below = true here to to change the position of the printf
      -- statement (or set two remaps for either one). This remap must be made in normal mode.
      vim.keymap.set('n', '<leader>fp', function()
        require('refactoring').debug.printf { below = false }
      end)
      -- Print var
      -- Supports both visual and normal mode
      vim.keymap.set({ 'x', 'n' }, '<leader>fg', function()
        require('refactoring').debug.print_var()
      end)
      -- Supports only normal mode
      vim.keymap.set('n', '<leader>fc', function()
        require('refactoring').debug.cleanup {}
      end)
    end,
  },
}
