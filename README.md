# dotfiles-nix

macOS flake layout using:

- `nix-darwin` for macOS system settings
- `nix-homebrew` + `homebrew` module for Homebrew packages and casks
- `home-manager` for user-level dotfiles and shell config

## Structure

```text
.
|-- flake.nix
|-- scripts/                 # Custom scripts installed into PATH
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
| **Dev Tools** | gh gitmux sesh starship uv yq                           |
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

Per-project dev environments are managed via [kalifun/devshells](https://github.com/kalifun/devshells) + `direnv`.

`mkdevshell` is installed globally as a system package. Use it to generate a `.envrc`:

```bash
mkdevshell simple rust-stable
```

**Modes:**
- **simple `<name>`** — writes `use flake github:kalifun/devshells#<shell>` to `.envrc`, activates immediately
- **composite** — interactive fzf multi-select to combine shells
- **template [name]** — initialize a project with `nix flake init`

Available shells: `go-latest`, `go-1_25`, `go-1_24`, `nodejs-22`, `nodejs-20`, `python-313`, `python-311`, `python-314`, `rust-stable`, `rust-nightly`, `rust-nightly-wasm`, `lua`, `zig`, `zig-latest`, `thrift`, `nix`, `java-android`

## Apply

Choose one bootstrap mode before the first apply.

### Option 1: Official Nix Installer

Set `nix.enable = true` in [`modules/darwin/settings.nix`](./modules/darwin/settings.nix).
In this mode, `nix-darwin` is allowed to manage the Nix installation.

Install Nix with the official installer, then open a new shell:

```bash
curl -L https://nixos.org/nix/install | sh
```

First apply:

Apple Silicon:

```bash
nix run github:LnL7/nix-darwin/master#darwin-rebuild -- switch --flake .#darwin-arm64-main
```

Intel:

```bash
nix run github:LnL7/nix-darwin/master#darwin-rebuild -- switch --flake .#darwin-x86_64-legacy
```

Later applies:

Apple Silicon:

```bash
sudo darwin-rebuild switch --flake .#darwin-arm64-main
```

Intel:

```bash
sudo darwin-rebuild switch --flake .#darwin-x86_64-legacy
```

### Option 2: Determinate Nix

Keep `nix.enable = false` in [`modules/darwin/settings.nix`](./modules/darwin/settings.nix).
In this mode, Nix is managed outside `nix-darwin`.

Install [Determinate Nix](https://determinate.systems/nix-installer), then open a new shell.

First apply:

Apple Silicon:

```bash
nix run github:LnL7/nix-darwin/master#darwin-rebuild -- switch --flake .#darwin-arm64-main
```

Intel:

```bash
nix run github:LnL7/nix-darwin/master#darwin-rebuild -- switch --flake .#darwin-x86_64-legacy
```

Later applies:

Apple Silicon:

```bash
sudo darwin-rebuild switch --flake .#darwin-arm64-main
```

Intel:

```bash
sudo darwin-rebuild switch --flake .#darwin-x86_64-legacy
```

In both modes, the first apply uses `nix run` because `darwin-rebuild` is usually not available until after the first successful switch.

You can also use the `rebuild` script from the dotfiles directory:

```bash
rebuild           # switch to current config
rebuild --update  # update all flake inputs, then switch
```

## Troubleshooting

### systemPackages disappear after reboot

On recent macOS versions, `System Settings > General > Login Items & Extensions > Allow in the Background`
may show some Nix-related background items as plain `sh` entries.

These are easy to mistake for something suspicious, but they are required for `nix-darwin` /
Determinate Nix boot integration. On this setup they may include:

- `org.nixos.activate-system`
- `org.nixos.darwin-store`
- `systems.determinate.nix-installer.nix-hook`

If you disable those `sh` entries, the system profile may not be restored on the next boot.
Typical symptoms:

- `/run/current-system` is missing after reboot
- commands from `environment.systemPackages` are no longer found
- shell startup reports errors such as `command not found: starship` or `command not found: zoxide`

If that happens, re-enable the related `sh` entries in `Allow in the Background` and reboot.
If you need an immediate recovery without rebooting, run:

```bash
sudo launchctl bootstrap system /Library/LaunchDaemons/org.nixos.activate-system.plist
sudo launchctl kickstart -k system/org.nixos.activate-system
```
