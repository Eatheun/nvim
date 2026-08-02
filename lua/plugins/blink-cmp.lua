-- LazyVim auto-enables blink.cmp as the default completion engine unless
-- something disables it (see LazyVim.config.init cmp autodetect). This repo
-- runs nvim-cmp manually instead (see cmp.lua) -- keep this disabled so both
-- completion engines don't attach at once.
return {
  "Saghen/blink.cmp",
  enabled = false,
}
