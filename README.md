### 💤 Setup

Pull this repo into your local machine at `~/.config/`

### Font

We also need to install a nerd font to see icons so head over to [Nerd Fonts](https://www.nerdfonts.com/) and download any font you want.

Install the font as,
```
mkdir ~/.fonts && mv ~/Downloads/*.zip ~/.fonts
cd ~/.fonts && unzip *.zip
fc-cache -fv
```

### Requirements

**Neovim 0.12.4+** — the LSP setup needs 0.11+ for the native `vim.lsp.config()` /
`vim.lsp.enable()` API, and current VimTeX refuses to load below 0.12.4. Debian's
`neovim` package is far too old (0.7); install via brew or upstream tarball.

Core tools, for the fuzzy finder and building treesitter parsers:

```
sudo apt install fzf ripgrep make gcc git
```

Language servers are installed by mason, but they need their runtimes on the host:

- `node` / `npm` — typescript-tools, tailwindcss, emmet, html
- `python3` — pyright, ruff

Optional:

- `zathura` — PDF viewer for vimtex (`vim.g.vimtex_view_method` in `lua/plugins/tex.lua`)
- `imagemagick` — image previews, see below

### Image previews

Telescope renders images in the preview pane through `snacks.image`, using the
Kitty graphics protocol (`lua/plugins/telescope.lua` overrides
`buffer_previewer_maker`). This has hard requirements on the *terminal*, not on
Neovim:

- **kitty >= 0.36** — Debian ships 0.26.5, which is too old. Install upstream:
  `curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin`
  (lands in `~/.local/kitty.app`; symlink `kitty` and `kitten` into `~/.local/bin`)
- **tmux >= 3.4** with `set -g allow-passthrough on` — bookworm ships 3.3a, whose
  passthrough mangles the bulk image payload. Install a newer one via brew.
- **imagemagick**

Failure signatures, since these are easy to misdiagnose:

| What you see | What it means |
| --- | --- |
| `Binary cannot be previewed` | Detection returned unsupported; it fell back to the text previewer. Terminal is too old, or tmux passthrough is off. |
| Blank / placeholder unicode blocks | Detection said supported, but the image bytes didn't survive the terminal or multiplexer. Usually tmux < 3.4 or kitty < 0.36. |

Check the terminal end first — `kitty +kitten icat some.png` inside tmux. If that
fails, the problem is not in this config.

### Outside this repo

These are needed for the above but live outside version control, so a fresh
machine needs them recreated by hand:

- `~/.config/tmux/tmux.conf` — `set -g allow-passthrough on`
- `~/.config/kitty/kitty.conf` — sets `shell` to the launcher below
- `~/.local/bin/kitty-tmux` — launcher that execs tmux by absolute path
  (a bare `tmux` resolves to the system one, silently bypassing a brew upgrade)
