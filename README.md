# dotfiles-nix

macOS flake layout using:

- `nix-darwin` for system-level Nix and macOS settings
- `nix-homebrew` + `homebrew` module for Homebrew packages and casks
- `home-manager` for user-level dotfiles and shell config

## Structure

```text
.
|-- flake.nix
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
    |   |-- neovim.nix
    |   |-- packages.nix
    |   |-- tmux.nix
    |   `-- zsh.nix
    `-- homebrew/
        `-- default.nix
```

## Reuse model

- Shared config lives in `modules/`
- Shared user config lives in `home/<username>/`
- Per-machine differences live in `hosts/<hostname>/`

Most of your CLI tools, shell config, dotfiles, and env vars should stay shared.
Host files should stay thin and only describe machine-specific differences.

## Current hosts

- `darwin-arm64-main`: Apple Silicon, `aarch64-darwin`
- `darwin-x86_64-legacy`: Intel, `x86_64-darwin`

These names are logical host roles, not hardware model names.

## What goes where

- System CLI tools like `neovim`, `tmux`, `fzf`, `git`, `ripgrep`: `modules/darwin/`
- GUI apps from Homebrew casks like Chrome, VSCode, iTerm2: `modules/homebrew/`
- User shell config, aliases, dotfiles, git config, session env vars: `modules/home-manager/`

## Apply

Apple Silicon:

```bash
nix --extra-experimental-features 'nix-command flakes' run github:LnL7/nix-darwin -- switch --flake .#darwin-arm64-main
```

Intel:

```bash
nix --extra-experimental-features 'nix-command flakes' run github:LnL7/nix-darwin -- switch --flake .#darwin-x86_64-legacy
```

## Next edits

- Replace `programs.git.userEmail`
- Add more `homebrew.casks`
- Move machine-specific apps into the relevant `hosts/<hostname>/default.nix`
