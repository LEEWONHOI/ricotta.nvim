-- gblame 확장
local Icons = require 'custom.plugins.ui.icons'

return {
  'lewis6991/gitsigns.nvim',
  ft = { 'gitcommit', 'diff' },
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    signs = {
      add = { text = Icons.gitsigns.add },
      change = { text = Icons.gitsigns.change },
      delete = { text = Icons.gitsigns.delete },
      topdelhfe = { text = Icons.gitsigns.topdelete },
      changedelete = { text = Icons.gitsigns.changedelete },
      untracked = { text = Icons.gitsigns.untracked },
    },
    current_line_blame = false,
    current_line_blame_opts = {
      delay = 300,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    preview_config = {
      -- Options passed to nvim_open_win
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
    -- preview_config = {
    --  border = Utils.telescope.borderchars("thick", "tl-t-tr-r-br-b-bl-l"), -- [ top top top - right - bottom bottom bottom - left ]
    -- },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      -- local map = Utils.safe_keymap_set
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { buffer = bufnr, expr = true, desc = 'Next git hunk' })
      map('n', '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { buffer = bufnr, expr = true, desc = 'Previous git hunk' })

      -- Actions
      map('n', '<leader>gs', gs.stage_hunk, { desc = 'Stage current hunk' })
      map('n', '<leader>gr', gs.reset_hunk, { desc = 'Reset current hunk' })
      map('v', '<leader>gs', function()
        gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Stage visual selection' })
      map('v', '<leader>gr', function()
        gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Reset visual selection' })
      map('n', '<leader>gS', gs.stage_buffer, { desc = 'Stage entire buffer' })
      map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Undo last hunk staging' })
      map('n', '<leader>gR', gs.reset_buffer, { desc = 'Reset entire buffer' })
      map('n', '<leader>gp', gs.preview_hunk, { desc = 'Preview current hunk changes' })
      map('n', '<leader>gb', function()
        gs.blame_line { full = true }
      end, { desc = 'Show blame for current line' })
      map('n', '<leader>gB', gs.toggle_current_line_blame, { desc = 'Toggle blame for current line' })
      map('n', '<leader>gd', gs.diffthis, { desc = 'Diff current hunk' })
      map('n', '<leader>gD', function()
        gs.diffthis '~'
      end, { desc = 'Diff all changes in the file' })
    end,
  },
}
