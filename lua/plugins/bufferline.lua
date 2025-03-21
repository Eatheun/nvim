return {
  "akinsho/bufferline.nvim",
  config = function()
    local bfl = require("bufferline")
    bfl.setup({
      options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        style_preset = bfl.style_preset.default, -- or bfl.style_preset.minimal,
        themable = true, -- true | false, -- allows highlight groups to be overriden i.e. sets highlights as default
        numbers = function(opts) -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
          return string.format("%s|%s", opts.ordinal, opts.raise(opts.id))
        end,
        close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
        indicator = {
          -- icon = "▎", -- this should be omitted if indicator style is not 'icon'
          style = "underline", -- 'icon' | 'underline' | 'none',
        },
        buffer_close_icon = "󰅖",
        modified_icon = "● ",
        close_icon = " ",
        left_trunc_marker = " ",
        right_trunc_marker = " ",

        --- name_formatter can be used to change the buffer's label in the bufferline.
        --- Please note some names can/will break the
        --- bufferline so use this at your discretion knowing that it has
        --- some limitations that will *NOT* be fixed.
        -- name_formatter = function(buf) -- buf contains:
        --   -- name                | str        | the basename of the active file
        --   -- path                | str        | the full path of the active file
        --   -- bufnr               | int        | the number of the active buffer
        --   -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
        --   -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
        -- end,

        max_name_length = 32,
        max_prefix_length = 8, -- prefix used when a buffer is de-duplicated
        truncate_names = true, -- whether or not tab names should be truncated
        tab_size = 20,
        diagnostics = "nvim_lsp", -- false | "nvim_lsp" | "coc",
        diagnostics_update_on_event = true, -- use nvim's diagnostic handler
        -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          if level == "error" then
            level = "  "
          elseif level == "warning" then
            level = "  "
          elseif level == "hint" then
            level = "  "
          elseif level == "info" then
            level = "  "
          else
            level = "  "
          end
          return count .. level
        end,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        custom_filter = function(buf_number, buf_numbers)
          -- filter out filetypes you don't want to see
          if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
            return true
          end
          -- filter out by buffer name
          if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
            return true
          end
          -- filter out based on arbitrary rules
          -- e.g. filter out vim wiki buffer from tabline in your work repo
          if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
            return true
          end
          -- filter out by it's index number in list (don't show first buffer)
          if buf_numbers[1] ~= buf_number then
            return true
          end
          return false
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Shoop Da Whoop", -- "File Explorer" | function ,
            text_align = "center", -- "left" | "center" | "right"
            separator = true,
          },
        },
        color_icons = true, -- true | false, -- whether or not to add the filetype icon highlights
        get_element_icon = function(element)
          -- element consists of {filetype: string, path: string, extension: string, directory: string}
          -- This can be used to change how bufferline fetches the icon
          -- for an element e.g. a buffer or a tab.
          -- e.g.
          local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
          return icon, hl
          -- or
          -- local custom_map = {my_thing_ft: {icon = "my_thing_icon", hl}}
          -- return custom_map[element.filetype]
        end,
        show_buffer_icons = true, -- true | false, -- disable filetype icons for buffers
        show_buffer_close_icons = false, -- true | false,
        show_close_icon = false, -- true | false,
        show_tab_indicators = true, -- true | false,
        show_duplicate_prefix = true, -- true | false, -- whether to show duplicate buffer prefix
        duplicates_across_groups = true, -- true | false, -- whether to consider duplicate paths in different groups as duplicates
        persist_buffer_sort = true, -- true | false, -- whether or not custom sorted buffers should persist
        move_wraps_at_ends = false, -- true | false, -- whether or not the move command "wraps" at the first or last position
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = "thick", -- "slant" | "slope" | "thick" | "thin" | { "any", "any" },
        enforce_regular_tabs = false, -- false | true,
        always_show_bufferline = true, -- true | false,
        auto_toggle_bufferline = true, -- true | false,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        sort_by = "insert_after_current", --  "insert_after_current" | "insert_at_end" | "id" | "extension" | "relative_directory" | "directory" | "tabs"
        -- | function(buffer_a, buffer_b)
        -- add custom logic
        --   local modified_a = vim.fn.getftime(buffer_a.path)
        --   local modified_b = vim.fn.getftime(buffer_b.path)
        --   return modified_a > modified_b
        -- end,
        pick = {
          alphabet = "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890",
        },
      },
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
  end,
  custom_areas = {
    right = function()
      local result = {}
      local seve = vim.diagnostic.severity
      local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
      local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
      local info = #vim.diagnostic.get(0, { severity = seve.INFO })
      local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

      if error ~= 0 then
        table.insert(result, { text = "  " .. error, link = "DiagnosticError" })
      end

      if warning ~= 0 then
        table.insert(result, { text = "  " .. warning, link = "DiagnosticWarn" })
      end

      if hint ~= 0 then
        table.insert(result, { text = "  " .. hint, link = "DiagnosticHint" })
      end

      if info ~= 0 then
        table.insert(result, { text = "  " .. info, link = "DiagnosticInfo" })
      end
      return result
    end,
  },
}
