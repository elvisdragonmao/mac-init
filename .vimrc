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