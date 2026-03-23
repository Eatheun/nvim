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
For live fuzzy finder to work, install `ripgrep`, and for building treesitter languages, install `make` and `gcc`,

```
sudo apt install ripgrep make gcc
```
