<div align="center">

[![Built Wit Ratatui][ratatui]][ratatui-link] 
[![Build Status][check]][check-link]
[![Crates.io][crates]][crates-link]
[![Downloads][downloads]][downloads-link]
[![License][license]][license-link]
[![Dependency Status][deps-badge]][deps]

[Installation](https://carch.chalisehari.com.np/getting-started/installation) •
[Documentation](https://carch.chalisehari.com.np) •
[Contributing](#contributing) •
[Changelog](https://github.com/harilvfs/carch/blob/main/CHANGELOG.md) •
[Roadmap](https://carch.chalisehari.com.np/project/roadmap)

</div>

## Carch

Carch is a CLI tool that helps you automate Linux setup after installation. It gives you a terminal UI to select and run grouped Bash scripts. You can install packages, desktop environments, tools, and much more with a few key presses.

This is useful when you don't want to go back and forth manually setting things up.

Works on Arch and Fedora based systems.

<details>

<summary> Features </summary>

- Terminal UI built with `ratatui`
- Grouped Bash scripts for everything from terminals to desktops
- Scripts are modular and organized by folders
- Works with pacman, AUR, flatpak, and other sources
- Not POSIX strict advanced Bash usage allowed
- Temporary run option to test without full install
- Add your own scripts easily, they show up automatically

</details>

<details>

<summary> Demo </summary>

<img src="https://raw.githubusercontent.com/harilvfs/carch/refs/heads/main/.github/preview.gif" />

</details>

<details>

<summary>  Quick Run / Testing  </summary>

You can run Carch without installing it permanently.

Stable version:

```bash
bash -c "$(curl -fsSL https://chalisehari.com.np/carch)"
```

Development version (if a pre-release is available):

```bash
bash -c "$(curl -fsSL https://chalisehari.com.np/carchdev)"
```

This will download and run Carch in a temporary place. It will be removed after you exit.

</details>

<details>

<summary> Usage </summary>

```bash
carch
```

Use ↑ ↓ ← → arrow keys to navigate categories and select scripts. Press Enter to run the selected script.

Some examples:

- System → Audio or Fonts
- Desktop → Hyprland or Dwm
- Terminal → Bash, Fish, or Zsh
- Development → Neovim or Bun

</details>

<details>

<summary> How It Works </summary>

Carch is built in Rust with `ratatui` for the terminal UI. Each entry in the UI is mapped to a Bash script inside the `modules/` folder.

The script runs inside a subprocess. Output is shown live in the terminal. Each script does its own logic you can use advanced Bash, package install commands, or fzf-based prompts.

Folder layout looks like this:

```bash
modules/
├── Browser/
│   └── Extensions.sh
├── colors.sh
├── Desktop/
│   ├── Dunst.sh
│   ├── Dwm.sh
│   ├── Hyprland.sh
│   ├── Picom.sh
│   ├── Rofi.sh
│   ├── Themes-Icons.sh
│   └── Wallpapers.sh
├── Development/
│   ├── Bun.sh
│   ├── Helix.sh
│   ├── Neovim.sh
│   └── Npm.sh
├── System/
│   ├── Audio.sh
│   ├── Aur.sh
│   ├── Bluetooth.sh
│   ├── Brightness.sh
│   ├── Chaotic-Aur.sh
│   ├── Fastfetch.sh
│   ├── Fonts.sh
│   ├── Grub.sh
│   ├── LTS-Kernel.sh
│   ├── packages/
│   │   ├── Packages-Android.sh
│   │   ├── Packages-Browsers.sh
│   │   ├── Packages-Communication.sh
│   │   ├── Packages-Crypto-Tools.sh
│   │   ├── Packages-Development.sh
│   │   ├── Packages-Editing.sh
│   │   ├── Packages-FileManagers.sh
│   │   ├── Packages-FM-Tools.sh
│   │   ├── Packages-Gaming.sh
│   │   ├── Packages-GitHub.sh
│   │   ├── Packages-Multimedia.sh
│   │   ├── Packages-Music.sh
│   │   ├── Packages-Productivity.sh
│   │   ├── Packages-Streaming.sh
│   │   ├── Packages-Terminals.sh
│   │   ├── Packages-TextEditors.sh
│   │   └── Packages-Virtualization.sh
│   ├── Packages.sh
│   └── Sddm.sh
└── Terminal/
    ├── Alacritty.sh
    ├── Bash.sh
    ├── Fish.sh
    ├── Foot.sh
    ├── Ghostty.sh
    ├── Kitty.sh
    ├── Tmux.sh
    └── Zsh.sh
```

If you drop a new `.sh` script into a proper folder, it will be picked up in the UI automatically.

</details>

<details>

<summary> Contributing </summary>

You can help by reporting bugs, adding new scripts, or improving the UI.

- Open issues or pull requests
- Use the docs: https://carch.chalisehari.com.np/project/contributing

</details>

<details>

<summary> Documentation </summary>

Full guide, installation, and more:

https://carch.chalisehari.com.np

</details>

<details>

<summary> License </summary>

Carch is under the MIT license.

```
Copyright 2025 Hari Chalise

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```

</details>

<!-- Badges -->

[ratatui]: https://ratatui.rs/built-with-ratatui/badge.svg
[ratatui-link]: https://ratatui.rs/

[check]: https://img.shields.io/github/actions/workflow/status/harilvfs/carch/ci.yml?branch=main&style=flat&color=1c1c29&labelColor=black&logo=github&logoColor=white
[check-link]: https://github.com/harilvfs/carch/actions/workflows/ci.yml

[downloads]: https://img.shields.io/github/downloads/harilvfs/carch/total?style=flat&color=1c1c29&logoColor=white&labelColor=black&logo=github
[downloads-link]: https://github.com/harilvfs/carch/releases/latest

[crates]: https://img.shields.io/crates/v/carch?style=flat&logo=rust&color=1c1c29&logoColor=white&labelColor=black
[crates-link]: https://crates.io/crates/carch

[deps-badge]: https://deps.rs/repo/github/harilvfs/carch/status.svg?path=%2F&subject=deps%3Acore&style=flat
[deps]: https://deps.rs/repo/github/harilvfs/carch?path=%2F

[license]: https://img.shields.io/github/license/harilvfs/carch?color=1c1c29&labelColor=black&style=flat&logo=github&logoColor=white
[license-link]: https://github.com/harilvfs/carch/blob/main/LICENSE
