return {
  "roobert/palette.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local red_mac = "#c31c2b"
    local red_mac_light = "#d34c5b"
    local red_mac_dark = "#950505"
    local red_mac_black = "#420505"
    local orange_mac = "#ff5800"
    local orange_mac_dark = "#b93a04"
    local yellow_mac = "#fdaf17"
    local yellow_mac2 = "#ffce84"
    local yellow_mac_light = "#fff0c0"
    local yellow_mac_punchy = "#ffef00"
    local green_mac = "#9dd304"
    local green_mac_light = "#eaff61"
    local green_mac_pale = "#7db304"
    require("palette").setup({
      palettes = {
        main = "custom_main_palette",
        accent = "custom_accent_palette",
        state = "custom_state_palette",
      },

      custom_palettes = {
        main = {
          custom_main_palette = {
            color0 = red_mac_black,
            color1 = red_mac_dark,
            color2 = orange_mac_dark,
            color3 = yellow_mac_light,
            color4 = orange_mac,
            color5 = yellow_mac,
            color6 = green_mac_pale,
            color7 = yellow_mac,
            color8 = yellow_mac2,
          },
        },
        accent = {
          custom_accent_palette = {
            accent0 = red_mac_light,
            accent1 = yellow_mac_punchy,
            accent2 = red_mac,
            accent3 = yellow_mac2,
            accent4 = green_mac,
            accent5 = yellow_mac,
            accent6 = green_mac_light,
          },
        },
        state = {
          custom_state_palette = {
            error = red_mac_light,
            warning = orange_mac,
            hint = yellow_mac2,
            ok = green_mac,
            info = green_mac_light,
          },
        },
      },
    })

    -- Set palette
    vim.cmd([[colorscheme palette]])

    -- Add manual overrides with vim.api.nvim_set_hl
    local ovrhl = vim.api.nvim_set_hl
    ovrhl(0, "@variable", { fg = yellow_mac, bold = true })
    ovrhl(0, "Operator", { fg = yellow_mac_light })
    ovrhl(0, "Keyword", { fg = orange_mac, bold = true })
  end,
}
