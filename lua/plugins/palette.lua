return {
  "roobert/palette.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local pri1 = "#f0efe7"
    local pri1_light = "#5f6180"
    local pri1_dark = "#2a2c4b"
    local pri1_black = "#2a2c4b"
    local pri2 = "#7847cb"
    local pri2_dark = "#434761"
    local sec1 = "#5f2cb5"
    local sec12 = "#"
    local sec12_dark = "#5e6278"
    local sec1_light = "#ffffff"
    local sec1_punchy = "#9362e2"
    local sec2 = "#9397ad"
    local sec2_light = "#6c9d1d"
    require("palette").setup({
      palettes = {
        main = "custom_main_palette",
        accent = "custom_accent_palette",
        state = "custom_state_palette",
      },

      custom_palettes = {
        main = {
          custom_main_palette = {
            color0 = pri1_black,
            color1 = pri1_dark,
            color2 = sec2_light,
            color3 = sec1_light,
            color4 = pri2,
            color5 = sec1,
            color6 = sec12_dark,
            color7 = sec1,
            color8 = sec12,
          },
        },
        accent = {
          custom_accent_palette = {
            accent0 = pri1_light,
            accent1 = sec1_punchy,
            accent2 = pri1,
            accent3 = sec12,
            accent4 = sec2,
            accent5 = sec1,
            accent6 = sec2_light,
          },
        },
        state = {
          custom_state_palette = {
            error = pri1_light,
            warning = pri2,
            hint = sec12,
            ok = sec2,
            info = sec2_light,
          },
        },
      },
    })

    -- Set palette
    vim.cmd([[colorscheme palette]])

    -- Add manual overrides with vim.api.nvim_set_hl
    local ovrhl = vim.api.nvim_set_hl
    ovrhl(0, "@variable", { fg = sec1, bold = true })
    ovrhl(0, "Operator", { fg = sec1_light })
    ovrhl(0, "Keyword", { fg = pri2, bold = true })
    ovrhl(0, "NeoTreeMessage", { fg = pri2_dark, bold = true })
    ovrhl(0, "NeoTreeDotFile", { fg = pri2_dark, bold = true })
    ovrhl(0, "Number", { fg = sec1_punchy, bold = true })
  end,
}
