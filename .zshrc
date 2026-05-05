# ─── p10k instant prompt (必須最上面) ──────────────────────────────
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ─── oh-my-zsh ────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ─── PATH (去重 prepend) ──────────────────────────────────────────
path_prepend() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *) export PATH="$1:$PATH" ;;
  esac
}

# ─── Node (先準備好，避免 pnpm/opencode global CLI 壞掉) ─────────────
export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh" --no-use
  nvm use --silent default >/dev/null 2>&1 || nvm use --silent node >/dev/null 2>&1
fi

export PNPM_HOME="$HOME/Library/pnpm"
path_prepend "$PNPM_HOME"
path_prepend "/opt/homebrew/opt/curl/bin"
path_prepend "/opt/homebrew/opt/ffmpeg-full/bin"
path_prepend "$HOME/.spicetify"

# ─── 環境變數 ──────────────────────────────────────────────────────
export EDITOR=vim
export VISUAL=vim
export GIT_EDITOR=vim     # 讓 git 更保險一定用 vim
export GH_EDITOR=vim      # 讓 gh 更保險一定用 vim
export GPG_TTY=$(tty)

# ─── 工具初始化 (輕量) ────────────────────────────────────────────
eval "$(zoxide init zsh)"
source <(fzf --zsh)

fuck() {
  unset -f fuck
  eval "$(thefuck --alias)"
  fuck "$@"
}

# ─── Aliases ──────────────────────────────────────────────────────
# pnpm
alias pn=pnpm
alias pnf="pnpm format"
alias pnd="pnpm dev"
alias pni="pnpm install"
alias pnr="pnpm run"
alias pnb="pnpm build"
alias pnc="pnpm check"
alias pns="pnpm start"

# 檔案 / 導覽
alias ls='eza --icons -lh --no-user'
alias cdd='cd ~/Desktop'

# git
alias gb='bash ~/.local/bin/better-git-branch.sh'

# 系統
alias coffee='sudo pmset -a disablesleep'

# ─── Functions ────────────────────────────────────────────────────
ytdl() {
  yt-dlp --extract-audio --audio-format mp3 --embed-thumbnail --add-metadata \
    --extractor-args "youtube:player_client=android" \
    -o "%(title)s.%(ext)s" \
    "$@"
}
