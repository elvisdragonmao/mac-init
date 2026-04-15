# 💻 Mac 馴服指南

當你剛抓到一隻野生的 MacBook 要怎麼把該拔的毛拔掉，該插的東西插進去，調教成一隻聽話敏感，會主動蹭過來，眼巴巴等著我下指令的乖狗狗。

> 白話文：我重置 macOS 之後會裝的軟體清單，還有一些設定。

## 設定

去設定太慢了，直接下指令吧：

> 參考自：<https://macos-defaults.com/>

### Dock

```bash
# Dock icon 大小
defaults write com.apple.dock "tilesize" -int "38"
# 自動隱藏 Dock
defaults write com.apple.dock "autohide" -bool "true"
# Dock 浮起時間（預設 0.5）
defaults write com.apple.dock "autohide-time-modifier" -float "0.5"
# Dock 浮起 Delay（預設 0.2）
defaults write com.apple.dock "autohide-delay" -float "0"
# 不要顯示最近開過的
defaults write com.apple.dock "show-recents" -bool "false"
# 重開 Dock 讓設定生效
killall Dock
```

### Finder

```bash
# 顯示所有檔案副檔名
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
# 顯示隱藏檔案
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
# 顯示檔案路徑
defaults write com.apple.finder "ShowPathbar" -bool "true"
# 關閉副檔名警告
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"
# 下載檔案到本機
defaults write NSGlobalDomain "NSDocumentSaveNewDocumentsToCloud" -bool "false"
# 顯示 Title bar icons
defaults write com.apple.universalaccess "showWindowTitlebarIcons" -bool "true"
# 移除 Toolbar title rollover delay
defaults write NSGlobalDomain "NSToolbarTitleViewRolloverDelay" -float "0"
# 顯示 Status bar
defaults write com.apple.finder "ShowStatusBar" -bool "true"
# 重開 Finder 讓設定生效
killall Finder
```

### 滑鼠

```bash
# 滑鼠加速
defaults write NSGlobalDomain com.apple.mouse.scaling -float "2"
# 點擊力度輕
defaults write com.apple.AppleMultitouchTrackpad "FirstClickThreshold" -int "0"
```

### 鍵盤

```bash
# Fn 鍵當作功能鍵(預設就是 False)
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool false
# 用 Tab 鍵切換控制項
defaults write NSGlobalDomain AppleKeyboardUIMode -int "2"
# 關閉雙空白句號
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
```

### 其他

```bash
# 分組視窗
defaults write com.apple.dock "expose-group-apps" -bool "true" && killall Dock
# 關閉 Apple Intelligence
defaults write com.apple.CloudSubscriptionFeatures.optIn "545129924" -bool "false"
```

## 軟體（指令安裝）

### Brew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```bash
# A-Z 排序
brew install ffmpeg # 影音轉檔工具
brew install git # 版本控制工具
brew install git-filter-repo # 重寫 Git 歷史
brew install gnupg # GPG 加密工具
brew install minio/stable/mc # MinIO 命令列工具
brew install nugget # iPhone 修補工具
brew install python3 # Python 執行環境
brew install thefuck # 指令更正工具
brew install tree # 顯示目錄結構
brew install vim # 終端文字編輯器
brew install yt-dlp # 網路影片下載工具

brew install --cask font-jetbrains-mono-nerd-font # 程式設計字型
brew install --cask ghostty # 終端機
brew install --cask vesktop # 第三方 Discord 用戶端
brew install --cask telegram # 即時通訊軟體
```

### Ghostty 設定

這裡可以打開鬼鬼來用囉！記得先給他 Full Disk Access 權限不然後面可能會卡指令。

![開啟 Full Disk Access](img/full-disk-access.png)

順便做一下設定：

```bash
mkdir -p '/Users/em/Library/Application Support/com.mitchellh.ghostty' && cat > '/Users/em/Library/Application Support/com.mitchellh.ghostty/config' <<'EOF'
quick-terminal-position = center
clipboard-write = allow
window-height = 20
window-width = 70
font-family = "FiraCode Nerd Font"

shell-integration-features = ssh-terminfo,ssh-env

background-opacity = 0.85
background-blur-radius = 16
theme = "TokyoNight"

clipboard-trim-trailing-spaces = true

auto-update = download
auto-update-channel = stable
EOF
```

### Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### .zshrc

```bash
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
```

### Vim 設定

使用 Vim 8+ 內建套件管理器安裝 Catppuccin

```
git clone https://github.com/catppuccin/vim.git ~/.vim/pack/vendor/start/catppuccin
```

自己貼一下吧：

```vim
" 關掉 Vi 相容模式，使用 Vim 自己的完整功能
set nocompatible

" 依檔案類型載入外掛與縮排規則
filetype plugin indent on

" 開啟語法高亮
syntax on

" 使用 UTF-8 編碼
set encoding=utf-8

" 顯示絕對行號
set number

" 同時顯示相對行號，跳行更方便
set relativenumber

" 高亮目前游標所在行
set cursorline

" 在右下角顯示目前模式
set showmode

" 在右下角顯示輸入中的指令
set showcmd

" 顯示游標所在的行列位置
set ruler

" 長行不要自動折到下一行
set nowrap

" 游標上下保留 5 行視野
set scrolloff=5

" 左右橫向捲動時保留 8 欄視野
set sidescrolloff=8

" 啟用滑鼠
set mouse=a

" 允許切到別的 buffer 時，不必先存檔
set hidden

" 保留較多指令歷史
set history=1000

" 讓某些事件更新更快，手感比較即時
set updatetime=300

" 組合鍵等待時間不要太長
set timeoutlen=500

" 搜尋時忽略大小寫
set ignorecase

" 但如果搜尋字串有大寫，就改成大小寫敏感
set smartcase

" 輸入搜尋字串時即時跳到匹配位置
set incsearch

" 高亮所有搜尋結果
set hlsearch

" 連按兩下 Esc 清掉搜尋高亮
nnoremap <Esc><Esc> :nohlsearch<CR>

" Tab 顯示為 2 個空白寬
set tabstop=2

" 自動縮排時使用 2 個空白
set shiftwidth=2

" 編輯時按 Tab 視為 2 個空白
set softtabstop=2

" 按 Tab 時插入空白，不是真的 Tab 字元
set expandtab

" 根據語法做基本智慧縮排
set smartindent

" 新行沿用上一行縮排
set autoindent

" 垂直分割新視窗開在右邊
set splitright

" 水平分割新視窗開在下面
set splitbelow

" 指令列補完顯示選單
set wildmenu

" 補完行為更接近現代編輯器
set wildmode=longest:full,full

" 插入模式補完選單行為設定
set completeopt=menuone,noinsert,noselect

" 補完選單最多顯示 10 行
set pumheight=10

" 啟用真彩色
set termguicolors

" 使用 Catppuccin Mocha 主題
colorscheme catppuccin_mocha

" 把 Tab、行尾空白等特殊字元顯示出來
set list

" 特殊字元的顯示樣式
set listchars=tab:»·,trail:·,nbsp:␣,extends:❯,precedes:❮

" 永遠顯示狀態列
set laststatus=2

" 清掉預設狀態列內容，改成自訂
set statusline=

" 狀態列左邊顯示檔名
set statusline+=\ %f

" 顯示是否已修改
set statusline+=%m

" 顯示是否唯讀
set statusline+=%r

" 顯示是否為 help buffer
set statusline+=%h

" 顯示是否為 preview window
set statusline+=%w

" 顯示檔案類型
set statusline+=\ [%{&filetype}]

" 顯示檔案編碼
set statusline+=\ [%{&fileencoding}]

" 顯示換行格式
set statusline+=\ [%{&fileformat}]

" 左右資訊推開
set statusline+=%=

" 顯示行號與欄號
set statusline+=\ Ln\ %l,\ Col\ %c

" 顯示目前檔案進度百分比
set statusline+=\ [%p%%]

" 如果 Vim 有剪貼簿支援，就直接共用系統剪貼簿
if has("clipboard")
  set clipboard=unnamed,unnamedplus
endif

" 不產生備份檔
set nobackup

" 寫入前不另外做暫存備份
set nowritebackup

" Leader 鍵設成空白鍵
let mapleader=" "

" 空白+w 存檔
nnoremap <leader>w :w<CR>

" 空白+q 離開
nnoremap <leader>q :q<CR>

" 空白+x 存檔並離開
nnoremap <leader>x :x<CR>

" Ctrl+h 切到左邊視窗
nnoremap <C-h> <C-w>h

" Ctrl+j 切到下面視窗
nnoremap <C-j> <C-w>j

" Ctrl+k 切到上面視窗
nnoremap <C-k> <C-w>k

" Ctrl+l 切到右邊視窗
nnoremap <C-l> <C-w>l

" 視覺模式縮排後保留選取範圍
vnoremap < <gv
vnoremap > >gv

" 讓 Y 的行為和 D/C 一樣，複製到行尾
nnoremap Y y$

" 遇到畫面上看起來換行的長行時，j/k 會照視覺行移動
nnoremap j gj
nnoremap k gk

" 針對不同檔案類型套用小調整
augroup my_filetypes
  autocmd!
  " Markdown 開啟自動折行、單字邊界換行，不顯示 list 符號
  autocmd FileType markdown setlocal wrap linebreak nolist
  " 一般文字與 git commit 訊息也使用較舒服的換行方式
  autocmd FileType text,gitcommit setlocal wrap linebreak
  " JSON 與 YAML 固定 2 空白縮排
  autocmd FileType json,yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2
  " Python 固定 4 空白縮排
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
augroup END
```

### Node.js

```bash
# 下載並安裝 nvm：
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

\. "$HOME/.nvm/nvm.sh" # 啟動
nvm install node # Node.js 執行環境
corepack enable pnpm # 啟用套件管理器代理
pnpm # JavaScript 套件管理器

pnpm i -g opencode # AI 助理 CLI
pnpm i -g prettier # 程式碼格式化工具
```

### Karabiner

```bash
vim /Users/em/.config/karabiner/karabiner.json
```

```json
{
	"global": { "show_in_menu_bar": false },
	"profiles": [
		{
			"complex_modifications": {
				"rules": [
					{
						"description": "Open Vesktop by left option + 3",
						"manipulators": [
							{
								"from": {
									"key_code": "3",
									"modifiers": {
										"mandatory": ["left_option"],
										"optional": ["caps_lock"]
									}
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/Applications/Vesktop.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open Sublime by left option + shift + x",
						"manipulators": [
							{
								"from": {
									"key_code": "x",
									"modifiers": {
										"mandatory": ["left_option", "left_shift"],
										"optional": ["caps_lock"]
									}
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/Applications/Sublime Text.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open VS Code by left option + 2",
						"manipulators": [
							{
								"from": {
									"key_code": "2",
									"modifiers": {
										"mandatory": ["left_option"],
										"optional": ["caps_lock"]
									}
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/Applications/Visual Studio Code.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open Telegram by left option + 0",
						"manipulators": [
							{
								"from": {
									"key_code": "0",
									"modifiers": { "mandatory": ["left_option"] }
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/Applications/Telegram.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open Discord by left option + 3",
						"enabled": false,
						"manipulators": [
							{
								"from": {
									"key_code": "3",
									"modifiers": {
										"mandatory": ["left_option"],
										"optional": ["caps_lock"]
									}
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/Applications/Discord.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Fn alone -> Esc",
						"manipulators": [
							{
								"conditions": [
									{
										"name": "fn-esc",
										"type": "variable_if",
										"value": 1
									}
								],
								"from": {
									"key_code": "fn",
									"modifiers": { "optional": ["shift", "option", "control", "command", "caps_lock"] }
								},
								"to": [
									{
										"key_code": "fn",
										"lazy": true
									}
								],
								"to_if_alone": [{ "key_code": "escape" }],
								"type": "basic"
							},
							{
								"from": {
									"key_code": "fn",
									"modifiers": { "optional": ["shift", "option", "control", "command", "caps_lock"] }
								},
								"to": [{ "key_code": "fn" }],
								"to_delayed_action": {
									"to_if_canceled": [
										{
											"set_variable": {
												"name": "fn-esc",
												"value": 0
											}
										}
									],
									"to_if_invoked": [
										{
											"set_variable": {
												"name": "fn-esc",
												"value": 0
											}
										}
									]
								},
								"to_if_alone": [
									{ "key_code": "escape" },
									{
										"set_variable": {
											"name": "fn-esc",
											"value": 1
										}
									},
									{
										"select_input_source": {
											"input_source_id": "com.apple.keylayout.ABC",
											"language": "^en$"
										}
									}
								],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open FireFox by left option + 1",
						"manipulators": [
							{
								"from": {
									"key_code": "1",
									"modifiers": {
										"mandatory": ["left_option"],
										"optional": ["caps_lock"]
									}
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/Applications/Firefox Developer Edition.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open Chrome by left option + shift + 1",
						"manipulators": [
							{
								"from": {
									"key_code": "1",
									"modifiers": {
										"mandatory": ["left_option", "left_shift"],
										"optional": ["caps_lock"]
									}
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/Applications/Google Chrome.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open Notion by left option + shift + 2",
						"manipulators": [
							{
								"from": {
									"key_code": "2",
									"modifiers": {
										"mandatory": ["left_option", "left_shift"],
										"optional": ["caps_lock"]
									}
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/Applications/Notion.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open iTerm by left option + 4",
						"enabled": false,
						"manipulators": [
							{
								"from": {
									"key_code": "4",
									"modifiers": { "mandatory": ["left_option"] }
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/Users/em/Applications/iTerm.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open Ghostty by left option + 4",
						"manipulators": [
							{
								"from": {
									"key_code": "4",
									"modifiers": { "mandatory": ["left_option"] }
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/Applications/Ghostty.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open Cursor by left option + 2",
						"enabled": false,
						"manipulators": [
							{
								"from": {
									"key_code": "2",
									"modifiers": {
										"mandatory": ["left_option"],
										"optional": ["caps_lock"]
									}
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/Applications/Cursor.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open AFFiNE by left option + 5",
						"manipulators": [
							{
								"from": {
									"key_code": "5",
									"modifiers": { "mandatory": ["left_option"] }
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/Applications/AFFiNE.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open LINE by left option + 9",
						"manipulators": [
							{
								"from": {
									"key_code": "9",
									"modifiers": { "mandatory": ["left_option"] }
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/Applications/LINE.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open Figma by left option + Q",
						"manipulators": [
							{
								"from": {
									"key_code": "q",
									"modifiers": {
										"mandatory": ["left_option"],
										"optional": ["caps_lock"]
									}
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/Applications/Figma.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open Calendar by left option + E",
						"manipulators": [
							{
								"from": {
									"key_code": "e",
									"modifiers": {
										"mandatory": ["left_option"],
										"optional": ["caps_lock"]
									}
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/System/Applications/Calendar.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open Reminders by left option + X",
						"manipulators": [
							{
								"from": {
									"key_code": "x",
									"modifiers": {
										"mandatory": ["left_option"],
										"optional": ["caps_lock"]
									}
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/System/Applications/Reminders.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open Element by left option + C",
						"manipulators": [
							{
								"from": {
									"key_code": "c",
									"modifiers": {
										"mandatory": ["left_option"],
										"optional": ["caps_lock"]
									}
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/Applications/Element.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open Finder by left option + '",
						"manipulators": [
							{
								"from": {
									"key_code": "quote",
									"modifiers": { "mandatory": ["left_option"] }
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/System/Library/CoreServices/Finder.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open Spotify by left option + \\",
						"manipulators": [
							{
								"from": {
									"key_code": "backslash",
									"modifiers": { "mandatory": ["left_option"] }
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/Applications/Spotify.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open Finder by F3",
						"manipulators": [
							{
								"from": {
									"key_code": "f3",
									"modifiers": { "optional": ["caps_lock"] }
								},
								"to": [{ "shell_command": "open ~/Desktop" }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Open Notes by left option + backtick",
						"manipulators": [
							{
								"from": {
									"key_code": "grave_accent_and_tilde",
									"modifiers": {
										"mandatory": ["left_option"],
										"optional": ["caps_lock"]
									}
								},
								"to": [{ "software_function": { "open_application": { "file_path": "/System/Applications/Notes.app" } } }],
								"type": "basic"
							}
						]
					},
					{
						"description": "Kill option + R",
						"enabled": false,
						"manipulators": [
							{
								"from": {
									"key_code": "r",
									"modifiers": {
										"mandatory": ["left_option"],
										"optional": ["caps_lock"]
									}
								},
								"to": [{ "key_code": "left_option" }, { "key_code": "r" }],
								"type": "basic"
							}
						]
					}
				]
			},
			"devices": [
				{
					"identifiers": {
						"is_keyboard": true,
						"is_pointing_device": true,
						"product_id": 591,
						"vendor_id": 1452
					},
					"ignore": false
				}
			],
			"fn_function_keys": [
				{
					"from": { "key_code": "f3" },
					"to": [{ "key_code": "f3" }]
				},
				{
					"from": { "key_code": "f4" },
					"to": [{ "key_code": "escape" }]
				}
			],
			"name": "Default profile",
			"selected": true,
			"virtual_hid_keyboard": { "keyboard_type_v2": "ansi" }
		}
	]
}
```

## App Store

有些軟體不得不使用 macOS App Store 下載：

- [Bitwarden](https://apps.apple.com/tw/app/bitwarden/id1352778147?l=en-GB&mt=12) - 密碼管理器
- [LINE](https://apps.apple.com/tw/app/line/id539883307?l=en-GB&mt=12) - 即時通訊軟體
- [Keynote](https://apps.apple.com/tw/app/keynote-design-presentations/id361285480?l=en-GB) - 簡報製作工具
- [WireGuard](https://apps.apple.com/tw/app/wireguard/id1451685025?l=en-GB&mt=12) - VPN 用戶端

## 應用程式

> 除非特別標示 🌐 為官網，其他為最新版本直接下載網頁。通常是下載的檔案名稱是有版本號的所以變成要特別寫個 bash 去抓最新版本因此直接放官網連結。

### 瀏覽器

- [Chrome 🌐](https://www.google.com/intl/zh-TW/chrome/) - 填滿你空虛的記憶體
- [Firefox Developer Edition](https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=osx&lang=zh-TW) - 水狐狸
- [Firefox 🌐](https://www.firefox.com/zh-TW/thanks/) - 火狐狸
- [Finicky 🌐](https://github.com/johnste/finicky/releases) - 瀏覽器 Reverse Proxy
- [Tor Browser 🌐](https://www.torproject.org/download/) - 讓人想哭的洋蔥瀏覽器

#### 瀏覽器擴充功能

- Bitwatden: [Firefox](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/) | [Chrome](https://chromewebstore.google.com/detail/bitwarden-password-manage/nngceckbapebfimnlniiiahkandclblb)
- Neat Download Manager: [Firefox](https://addons.mozilla.org/en-US/firefox/addon/neatdownloadmanager-extension/) | [Chrome](https://chromewebstore.google.com/detail/neatdownloadmanager-exten/cpcifbdmkopohnnofedkjghjiclmhdah)
- Wappalyzer: [Firefox](https://addons.mozilla.org/en-US/firefox/addon/wappalyzer/) | [Chrome](https://chromewebstore.google.com/detail/wappalyzer-technology-pro/gppongmhjkpfnbhagpmjfkannfbllamg)
- Tampermonkey: [Firefox](https://addons.mozilla.org/en-US/firefox/addon/tampermonkey/) | [Chrome](https://chromewebstore.google.com/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo)
- [Url to QrCode](https://addons.mozilla.org/zh-TW/firefox/addon/url-to-qrcode/)

### 網路

- [Cloudflare WARP](https://1111-releases.cloudflareclient.com/mac/latest) - 免費加速 VPN
- [balenaEtcher](https://etcher.balena.io/#download-etcher) 🌐 - 開機碟燒錄工具
- [FortiClient](https://links.fortinet.com/forticlient/mac/vpnagent) - 學校公司 VPN
- [NeatDownloadManager](https://neatdownloadmanager.com/file/NeatDMInstaller.dmg) - 下載管理工具
- [Proxyman](https://proxyman.com/release/osx/Proxyman_latest.dmg) - HTTP 封包分析工具
- [Tailscale 🌐](https://pkgs.tailscale.com/stable/#macos) - 私有網路工具
- [VNC Viewer 🌐](https://www.realvnc.com/en/connect/download/viewer/) - 遠端桌面工具

### Office 全家桶

#### 開新版

> [延伸閱讀：【開源】快速免費啟用 Office 及 Windows | 毛哥EM 資訊密技](https://emtech.cc/p/massgrave)

#### 教育版

> 這裡以交大為例。每間學校的方案不同不一定有買 A3 桌面版 App。

- 請先確認你有交大提供的教育版 Microsoft 365 帳號。登入 [NYCU Portal](https://portal.nycu.edu.tw/#/) 後選擇 Microsoft 365 服務申請。
- 進入 [Office.com](https://www.office.com/) > 左下角應用程式 > 更多應用程式 > 右上角安裝應用程式 > Microsoft 365 應用程式 > [Office 應用程式與裝置](https://portal.office.com/account/) > 安裝 Office

### 數位創作

- [Creative Cloud](https://www.adobe.com/download/creative-cloud)（訂閱） - Adobe 應用程式管理工具
- [Blender](https://www.blender.org/download/) - 3D 建模與動畫工具
- [DaVinci Resolve 🌐](https://www.blackmagicdesign.com/products/davinciresolve) - 影片剪輯與調色工具
- [Figma](https://www.figma.com/download/desktop/mac) - 工程師設計工具

### 桌面工具

- [Alcove](https://tryalcove.com/download)（買斷） - 桌面整理工具
- [Liqoria](https://liqoria.com/download)（買斷） - 桌面增強工具
- [Stats](https://github.com/exelban/stats/releases/download/latest/Stats.dmg)（開源） - 系統監控工具
- [Raycast 🌐](https://www.raycast.com/) - 更好用的 Spotlight
- [Karabiner-Elements 🌐](https://karabiner-elements.pqrs.org/) - 鍵盤自訂工具

### 寫 Code

- [Visual Studio Code 🌐](https://code.visualstudio.com/thank-you?dv=osx) - 程式碼編輯器
- [Zed 🌐](https://zed.dev/download) - 程式碼編輯器
- [ChatGPT](https://persistent.oaistatic.com/sidekick/public/ChatGPT.dmg) - AI 助理
- [Arduino IDE 🌐](https://www.arduino.cc/en/software/) - Arduino 開發工具
- [Docker Desktop](https://desktop.docker.com/mac/main/arm64/Docker.dmg) - 容器化工具
- [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=macM1) - JetBrains 工具管理器
- [Sublime Text](https://www.sublimetext.com/download_thanks?target=mac) - 輕量文字編輯器

### Self-hosted

- [AFFiNE](https://affine.pro/download) 🌐 - 筆記與協作工具
- [ente 🌐](https://ente.com/download/) - 相片備份工具
- [Nextcloud 🌐](https://nextcloud.com/install/#desktop-files) - 自架雲端平台

### 工具

- [OBS 🌐](https://obsproject.com/) - 錄影與直播工具
- [Keka](https://d.keka.io/) - 壓縮與解壓縮工具

### 社群軟體

- [Element](https://packages.element.io/desktop/install/macos/Element.dmg) - Matrix 用戶端

- _[Discord](https://discord.com/api/download?platform=osx) - 社群與語音軟體，剛才裝過 Vesktop 就不需要了_

### 驅動程式

- [EVO 🌐](https://arc.audient.com/) - 錄音介面驅動程式
- [Options+](https://download01.logi.com/web/ftp/pub/techsupport/optionsplus/logioptionsplus_installer.zip) - 羅技裝置設定工具

### 辦公

- [Notion](https://www.notion.com/desktop/mac-universal/download) - 筆記與協作工具
- [Parallels Desktop](https://www.parallels.com/products/desktop) - 虛擬機工具（訂閱）
- [Thunderbird 🌐](https://www.thunderbird.net/zh-TW/thunderbird/all/) - 電子郵件用戶端
- [Typora](https://downloads.typora.io/mac/) - Markdown 編輯器
- [Zotero](https://www.zotero.org/download/client/dl?channel=release&platform=mac) - 文獻管理工具

### 音樂

- [VLC 🌐](https://images.videolan.org/vlc/index.zh_TW.html) - 多媒體播放器
- [Spotify](https://download.scdn.co/SpotifyInstaller.zip) - 音樂串流服務

### 其他

- [SDR++](https://www.sdrpp.org/nightly) - 軟體無線電工具
