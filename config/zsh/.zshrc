# ~/.zshrc - Zsh configuration

# === Path ===
export PATH="$HOME/.local/bin:$PATH"

# === Homebrew ===
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# === Rust 清华源 ===
export RUSTUP_DIST_SERVER="https://mirrors.tuna.tsinghua.edu.cn/rustup"
export RUSTUP_UPDATE_ROOT="https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup"

# === Starship ===
eval "$(starship init zsh)"

# === Zoxide ===
eval "$(zoxide init zsh)"

# === Aliases ===
alias ll='eza -lah'
alias vim='nvim'
alias cat='bat'

# === Editor ===
export EDITOR='nvim'
export VISUAL='nvim'

# === Language-specific ===

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Node
export PATH="$PATH:node_modules/.bin"

# Python
export PATH="$PATH:$HOME/.local/bin"

# === Local config ===
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
