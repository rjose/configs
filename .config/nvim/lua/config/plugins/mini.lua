return {
  {
    'echasnovski/mini.nvim',
    config = function()
      local statusline = require 'mini.statusline'

      -- Override mode display function before setup
      local original_section_mode = statusline.section_mode
      statusline.section_mode = function(args)
        local mode_map = {
          ['Normal'] = 'NM',
          ['Insert'] = 'IN',
          ['Visual'] = 'VS',
          ['V-Line'] = 'VL',
          ['V-Block'] = 'VB',
          ['Command'] = 'CM',
          ['Replace'] = 'RP',
          ['Terminal'] = 'TM',
          ['Select'] = 'SE',
          ['S-Line'] = 'SL',
          ['S-Block'] = 'SB',
        }

        local mode, mode_hl = original_section_mode(args)
        local short_mode = mode_map[mode] or mode
        return short_mode, mode_hl
      end

      -- Enable nerd font support
      vim.g.have_nerd_font = true
      
      statusline.setup {
        use_icons = true,
        content = {
          active = function()
            local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
            local git = statusline.section_git({ trunc_width = 75 })
            local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
            local lsp = statusline.section_lsp({ trunc_width = 75 })
            local filename = statusline.section_filename({ trunc_width = 140 })
            local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
            local location = statusline.section_location({ trunc_width = 75 })
            local search = statusline.section_searchcount({ trunc_width = 75 })

            return statusline.combine_groups({
              { hl = mode_hl,                 strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { git } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=', -- Right align
              -- { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = mode_hl,                  strings = { location } },
            })
          end,
          inactive = function()
            return '%#MiniStatuslineInactive#%F%='
          end
        }
      }
    end
  }
}
