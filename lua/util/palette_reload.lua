local M = {}

function M.apply()
  package.loaded["palette_data"] = nil
  local p = require("palette_data")

  -- palette.nvim's own submodules (theme.lua, highlights.lua, etc.) compute
  -- their derived colour tables at module top-level, which Lua only ever
  -- runs once per require — clear them so they recompute from the fresh
  -- custom_palettes below instead of replaying colours from first load.
  for name, _ in pairs(package.loaded) do
    if name == "palette" or name:match("^palette%.") then
      package.loaded[name] = nil
    end
  end

  require("palette").setup({
    palettes = {
      main = "custom_main_palette",
      accent = "custom_accent_palette",
      state = "custom_state_palette",
    },

    custom_palettes = {
      main = {
        custom_main_palette = {
          color0 = p.pri1_black,
          color1 = p.pri1_dark,
          color2 = p.sec2_light,
          color3 = p.sec1_light,
          color4 = p.pri2,
          color5 = p.sec1,
          color6 = p.sec12_dark,
          color7 = p.sec1,
          color8 = p.sec12,
        },
      },
      accent = {
        custom_accent_palette = {
          accent0 = p.pri1_light,
          accent1 = p.sec1_punchy,
          accent2 = p.pri1,
          accent3 = p.sec12,
          accent4 = p.sec2,
          accent5 = p.sec1,
          accent6 = p.sec2_light,
        },
      },
      state = {
        custom_state_palette = {
          error = p.pri1_light,
          warning = p.pri2,
          hint = p.sec12,
          ok = p.sec2,
          info = p.sec2_light,
        },
      },
    },
  })

  vim.cmd([[colorscheme palette]])

  local ovrhl = vim.api.nvim_set_hl
  ovrhl(0, "@variable", { fg = p.sec1, bold = true })
  ovrhl(0, "Operator", { fg = p.sec1_light })
  ovrhl(0, "Keyword", { fg = p.pri2, bold = true })
  ovrhl(0, "NeoTreeMessage", { fg = p.pri2_dark, bold = true })
  ovrhl(0, "NeoTreeDotFile", { fg = p.pri2_dark, bold = true })
  ovrhl(0, "Number", { fg = p.sec1_punchy, bold = true })
end

return M
