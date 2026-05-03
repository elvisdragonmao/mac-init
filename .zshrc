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

# ─── 懶載入 (重的東西，第一次用到才載) ───────────────────────────
export NVM_DIR="$HOME/.nvm"
_load_nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
nvm()  { _load_nvm; nvm  "$@"; }
node() { _load_nvm; node "$@"; }
npm()  { _load_nvm; npm  "$@"; }
npx()  { _load_nvm; npx  "$@"; }

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
