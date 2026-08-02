-- Manually re-apply the wallpaper-derived colour palette (also triggered
-- live by colour_de via --listen sockets, see lua/util/palette_reload.lua)
vim.api.nvim_create_user_command("PaletteReload", function()
  require("util.palette_reload").apply()
end, {})

-- Clean up this instance's --listen socket on exit (see the `nvim` wrapper
-- function in ~/.bashrc) so /tmp/nvim-sockets doesn't accumulate dead files
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    local addr = vim.v.servername
    if addr and addr ~= "" and vim.uv.fs_stat(addr) then
      os.remove(addr)
    end
  end,
})
