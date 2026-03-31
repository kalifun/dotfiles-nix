# dotfiles-nix

macOS flake layout using:

- `nix-darwin` for system-level Nix and macOS settings
- `nix-homebrew` + `homebrew` module for Homebrew packages and casks
- `home-manager` for user-level dotfiles and shell config

## Structure

```text
.
|-- flake.nix
|-- scripts/                 # Custom scripts installed into PATH
|   |-- mkdevshell           # Interactive devshell generator
|   `-- rebuild              # Build and switch system configuration
|-- config/                  # Dotfile configs (symlinked)
|   |-- ghostty/
|   |-- karabiner/
|   |-- nvim/
|   |-- rime/
|   |-- starship.toml
|   |-- tmux/
|   `-- zsh/
|-- hosts/
|   |-- darwin-arm64-main/
|   |   `-- default.nix
|   `-- darwin-x86_64-legacy/
|       `-- default.nix
|-- home/
|   `-- <username>/
|       `-- default.nix
`-- modules/
    |-- darwin/
    |   |-- default.nix
    |   |-- packages.nix
    |   `-- settings.nix
    |-- home-manager/
    |   |-- default.nix
    |   |-- git.nix
    |   |-- packages.nix
    |   |-- zsh.nix
    `-- homebrew/
        `-- default.nix
```

## Installed Software

### CLI Tools (Nix)

| Category      | Tools                                                   |
| ------------- | ------------------------------------------------------- |
| **Core**      | bat eza fd fzf git neovim ripgrep tmux tree wget zoxide |
| **Languages** | go rust rust-analyzer python3 nodejs                    |
| **Dev Tools** | gh gitmux sesh starship yq                              |
| **Shell**     | oh-my-zsh zsh-autosuggestions zsh-syntax-highlighting   |

### GUI Apps (Homebrew Casks)

| Category          | Apps                                               |
| ----------------- | -------------------------------------------------- |
| **Communication** | WeChat DingTalk Telegram QQ                        |
| **Input**         | Squirrel (Rime)                                    |
| **Browser**       | Arc Chrome                                         |
| **IDE**           | Zed VSCode Neovim                                  |
| **AI**            | CC-Switch                                          |
| **Note**          | Obsidian Logseq                                    |
| **Terminal**      | Ghostty iTerm2                                     |
| **Player**        | IINA                                               |
| **Productivity**  | Raycast Karabiner Easydict OrbStack MonitorControl |
| **Other**         | Snipaste f.lux Beekeeper Studio Mos MQTTX          |
| **Fonts**         | Fira Code Monaspace                                |
| **Proxy**         | clash-party                                        |

### Homebrew Brews

- `mole` - Deep clean and optimize Mac

### Dotfile Configs

| Config        | Location                             |
| ------------- | ------------------------------------ |
| **Ghostty**   | `~/.config/ghostty`                  |
| **Karabiner** | `~/.config/karabiner`                |
| **Neovim**    | `~/.config/nvim`                     |
| **Rime**      | `~/Library/Rime` (rime-ice + custom) |
| **Starship**  | `~/.config/starship.toml`            |
| **Tmux**      | `~/.config/tmux`                     |
| **Zsh**       | `~/.zshrc`                           |

## Reuse model

- Shared config lives in `modules/`
- Shared user config lives in `home/<username>/`
- Dotfile configs live in `config/` (symlinked)
- Per-machine differences live in `hosts/<hostname>/`

Most of your CLI tools, shell config, dotfiles, and env vars should stay shared.
Host files should stay thin and only describe machine-specific differences.

## Current hosts

- `darwin-arm64-main`: Apple Silicon, `aarch64-darwin`
- `darwin-x86_64-legacy`: Intel, `x86_64-darwin`

These names are logical host roles, not hardware model names.

## What goes where

- System CLI tools: `modules/darwin/packages.nix`
- GUI apps from Homebrew: `modules/homebrew/default.nix`
- User shell config: `modules/home-manager/zsh.nix`
- Dotfile configs: `config/` (symlinked via `home/<username>/default.nix`)
- Custom scripts: `scripts/` (installed into PATH via `modules/home-manager/packages.nix`)

## Dev Shells

Per-project dev environments are managed via [acehinnnqru/devshells](https://github.com/acehinnnqru/devshells) + `direnv`.

Use the `mkdevshell` script to generate a `.envrc` interactively:

```bash
mkdevshell
```

Two modes:
- **simple** — writes `use flake github:acehinnnqru/devshells#<shell>` to `.envrc`, activates immediately
- **template** — runs `nix flake init` to generate a local `flake.nix` (customizable), then writes `use flake .` to `.envrc`

Available shells: `go-latest`, `go-1_25`, `go-1_24`, `nodejs-22`, `nodejs-20`, `python-313`, `python-311`, `rust-stable`, `rust-nightly`, `rust-nightly-wasm`, `lua`, `zig`, `zig-latest`, `thrift`, `nix`

## Apply

This repo expects `nix-darwin` to manage Nix itself, including `nix-command` and `flakes`.
On a brand new macOS machine, install Nix once as bootstrap, then immediately apply this flake.

Bootstrap:

```bash
curl -L https://nixos.org/nix/install | sh
```

After the installer finishes, open a new shell and run:

Apple Silicon:

```bash
sudo darwin-rebuild switch --flake .#darwin-arm64-main
```

Intel:

```bash
sudo darwin-rebuild switch --flake .#darwin-x86_64-legacy
```

After the initial bootstrap, use the `rebuild` script from the dotfiles directory:

```bash
rebuild           # switch to current config
rebuild --update  # update all flake inputs, then switch
```
