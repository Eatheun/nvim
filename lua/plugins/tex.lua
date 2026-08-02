return {
  "lervag/vimtex",
  -- upstream recommends against lazy loading, since VimTeX normally installs
  -- its own filetype detection. Neovim already detects .tex/.sty as tex and
  -- .bib as bib on its own, so loading on those is fine -- but .cls files are
  -- detected as "st", so open those with `:set ft=tex` to get VimTeX.
  ft = { "tex", "bib" },
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- must stay in `init`: lazy.nvim runs it during startup, so the variable
    -- is set before VimTeX itself loads
    vim.g.vimtex_view_method = "zathura"
  end,
}
