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
brew install thefuck # 錯誤指令修正
brew install git # 版本控制
brew install git-filter-repo # 焚書坑儒
brew install minio/stable/mc # minIO CLI
brew install python3 # Python 3
brew install tree # 目錄結構顯示
brew install ffmpeg # 影音轉檔
brew install yt-dlp # YouTube 下載

brew install --cask ghostty
```

這裡可以打開鬼鬼來用囉！記得先給他 Full Disk Access 權限不然後面可能會卡指令。

![開啟 Full Disk Access](img/full-disk-access.png)

### Node.js

```bash
# 下載並安裝 nvm：
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

\. "$HOME/.nvm/nvm.sh" # 讓 nvm 可用
nvm install 24 # 安裝 Node.js 24
corepack enable pnpm # 啟用 corepack
pnpm # 安裝 pnpm

pnpm install -g opencode # 助理
## 應用程式
```

## 應用程式

> 這裡安裝連結待補上

* Ableton Live 12 Standard
* Adobe Creative Cloud
* Adobe Illustrator 2026
* Adobe Photoshop 2026
* AFFiNE
* Alcove
* Arduino IDE
* balenaEtcher
* Bitwarden
* Blackmagic Proxy Generator Lite
* Blackmagic RAW
* Blender
* ChatGPT
* Cloudflare WARP
* Codex
* DaVinci Resolve
* Discord
* Docker
* Element
* ente
* EVO
* Figma
* Finicky
* Firefox Developer Edition
* FortiClient
* FortiClientUninstaller
* Ghostty
* Google Chrome
* JetBrains Toolbox
* Karabiner-Elements
* Karabiner-EventViewer
* Keka
* Keynote Creator Studio
* LINE
* Liqoria
* logioptionsplus
* Microsoft Excel
* Microsoft PowerPoint
* Microsoft Word
* NeatDownloadManager
* Nextcloud
* Notion
* OBS
* Parallels Desktop
* Proxyman
* Raycast
* SDR++
* Spotify
* Stats
* Sublime Text
* Tailscale
* Telegram
* Thunderbird
* Tor Browser
* Typora
* Utilities
* VencordInstaller
* Vesktop
* Visual Studio Code
* VLC
* VNC Viewer
* WireGuard
* Zed
* Zotero