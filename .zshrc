if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions you-should-use)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias pn=pnpm
alias pnf="pnpm format"
alias pnd="pnpm dev"
alias pni="pnpm install"
alias pnr="pnpm run"
alias pnb="pnpm build"
alias pnc="pnpm check"
alias pns="pnpm start"

alias cdd='cd ~/Desktop'

eval $(thefuck --alias)

alias pip='uv run pip'

alias coffee='sudo pmset -a disablesleep'
alias pyenv="source ~/.venv/bin/activate"

# pnpm
export PNPM_HOME="/Users/em/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export SSH_AUTH_SOCK=/Users/em/.bitwarden-ssh-agent.sock
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
alias get_idf='. /Users/em/uwu/esp-idf/export.sh'

ytdl() {
  yt-dlp --extract-audio --audio-format mp3 --embed-thumbnail --add-metadata \
    --extractor-args "youtube:player_client=android" \
    -o "%(title)s.%(ext)s" \
    "$@"
}

eval "$(zoxide init zsh)"
source <(fzf --zsh)

alias ls='eza --icons -lh --no-user'
alias gb='bash ~/Scripts/better-git-branch.sh'

export EDITOR=vim
export VISUAL=vim
export GH_EDITOR=vim      # 讓 gh 更保險一定用 vim
export GIT_EDITOR=vim     # 讓 git 更保險一定用 vim
export PATH="/opt/homebrew/opt/ffmpeg-full/bin:$PATH"

export SSH_AUTH_SOCK=~/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock

export GPG_TTY=$(tty)

export PATH=$PATH:/Users/em/.spicetify
```

### Git 設定

```bash
echo .DS_Store >> ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
git config --global pull.rebase true
git config --global user.name ""
git config --global user.email ""

# 如果要簽名
git config --global commit.gpgsign true
git config --global gpg.program gpg