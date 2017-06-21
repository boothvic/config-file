"===========Base Setting==================="
syntax enable
syntax on
set t_Co=256
set autoindent
set cindent
set smartindent
set autowrite
set number
set laststatus=2
""set spell
""set mouse=a
"===========End Base Settings=============="

"========Python specific settings=========="
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
""set noexpandtab
setlocal formatoptions=croql
""nmap <F5> :w <CR> :!clear; python % <CR>
""nmap <F6> :w <CR> :!python %
""set foldmethod=indent 缩进折叠
let python_highlight_all=1

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
"========End Python specific settings. ==========="
"
"============File Browse Settings================="
"记录光标位置
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
""filetype on
set scrolloff=5
""设置以unix的格式保存文件
set fileformat=unix
set fenc=utf-8
""Real time search
set incsearch
set hlsearch
""突出显示当前行/列
""set cursorline
""set cursorcolumn
"hide toptab
""set showtabline=0
"===========End File Browse Settings=============="

"============New file title settings.======================
autocmd BufNewFile *.cpp,*.[ch],*.py,*.java exec ":call SetTitle()"
func SetTitle()
    if &filetype == "c"
		call setline(1,"/*")
		call append(line(".")," * Author: Vic Lin   File Name: " .expand("%"))
		call append(line(".")+1," * Created Time: ".strftime("%c"))
		call append(line(".")+2," *")
		call append(line(".")+3," * C source code - replace this with a description")
		call append(line(".")+4," * of the code and write the code below this text")
		call append(line(".")+5," *")
		call append(line(".")+6," */")
		call append(line(".")+7,"")
		call append(line(".")+8,"")
	    call append(line(".")+9,"#include <stdio.h>")
	    call append(line(".")+10,"")
	    call append(line(".")+11,"int main(int argc, char **argv)")
	    call append(line(".")+12,"{")
	    call append(line(".")+13,"    return 0;")
	    call append(line(".")+14,"}")
    elseif &filetype == "cpp"
		call setline(1,"/*")
		call append(line(".")," * Author: Vic Lin    File Name: ".expand("%"))
		call append(line(".")+1," * Created Time: ".strftime("%c"))
		call append(line(".")+2," *")
		call append(line(".")+3," * Cpp source code - replace this with a description")
		call append(line(".")+4," * of the code and write the code below this text")
		call append(line(".")+5," *")
		call append(line(".")+6," */")
		call append(line(".")+7,"")
		call append(line(".")+8,"")
		call append(line(".")+9,"#include <iostream>")
		call append(line(".")+10,"using namespace std;")
	    call append(line(".")+11,"")
	    call append(line(".")+12,"int main(int argc, char **argv)")
	    call append(line(".")+13,"{")
	    call append(line(".")+14,"    return 0;")
	    call append(line(".")+15,"}")
    elseif &filetype == "java"
		call setline(1,"/*")
		call append(line(".")," * Author: Vic Lin    File Name: ".expand("%"))
		call append(line(".")+1," * Created Time: ".strftime("%c"))
		call append(line(".")+2," *")
		call append(line(".")+3," * Java source code - replace this with a description")
		call append(line(".")+4," * of the code and write the code below this text")
		call append(line(".")+5," *")
		call append(line(".")+6," */")
		call append(line(".")+7,"")
		call append(line(".")+8,"")
		call append(line(".")+9,"public class unnamed {")
		call append(line(".")+10,"")
		call append(line(".")+11,"    public static void main (String[] args) {")
		call append(line(".")+12,"    }")
		call append(line(".")+13,"}")
	else
		call setline(1,"\#!/usr/bin/env python")
		call append(line("."),"\# -*- coding: utf-8 -*-")
		call append(line(".")+1,"\#")
		call append(line(".")+2,"\# ".expand("%"))
		call append(line(".")+3,"\#")
		call append(line(".")+4,"\# Vim: tabstop=4 expandtab shiftwidth=4 softtabstop=4")
		call append(line(".")+5,"\# Python source code - replace this with a description")
		call append(line(".")+6,"\# of the code and write the code below this text")
		call append(line(".")+7,"\#")
		call append(line(".")+8,"")
		call append(line(".")+9,"def main(args):")
		call append(line(".")+10,"    return 0")
		call append(line(".")+11,"")
		call append(line(".")+12,"if __name__ == '__main__':")
		call append(line(".")+13,"    import sys")
		call append(line(".")+14,"    sys.exit(main(sys.argv))")
	endif
endfunc
autocmd BufNewFile * normal G2k
"===================End new file settings.================
"自动补全符号
inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>
""inoremap { {<CR>}<ESC>O
""inoremap } <c-r>=ClosePair('}')<CR>
""inoremap { {<CR>}<ESC>i
""inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
function! ClosePair(char)
	if getline('.')[col('.')- 1]== a:char
		return "\<Right>"
	else
		return a:char
	endif
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""
"代码补全 
""set completeopt=preview,menu
""omnocppcomplete
set nocp
set completeopt+=longest
autocmd InsertLeave * if pumvisible()==0|pclose|endif
inoremap <expr> <CR>	pumvisible() ? "\<C-y>" : "\<CR>"	
inoremap <expr> <Down>	pumvisible() ? "\<C-n>" : "\<Down>"	
inoremap <expr> <Up>	pumvisible() ? "\<C-p>" : "\<Up>"	
inoremap <expr> <PageDown>	pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"	
inoremap <expr> <PageUp>	pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"	
""""""""""""""""""""""""""""""""""""""""""""""""""""""
"==============Keyboard Shortcuts Settings============"
"去空行  
nnoremap <F3> :g/^\s*$/d<CR>
"行号隐藏和显示
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
""代码语法高亮折叠
set foldmethod=syntax
""折叠层数
set foldlevel=99
""set foldlevelstart=99
""折叠区域宽度
""set foldcolumn=4
""折叠打开/关闭
map <F9> za 
"++++++++++++++++++++++++++++++++++++++++++++++++"
"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!gcc % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!java %<"
	elseif &filetype == 'sh'
		:!./%
	elseif &filetype == 'py'
		exec "!python %"
		exec "!python %<"
    endif
endfunc
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc
""==========Bundle Settings=========================
set nocompatible
"filetype off
" 设置包括vundle和初始化相关的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"" 另一种选择, 指定一个vundle安装插件的路径
"call vundle#begin('~/some/path/here')
" 让vundle管理插件版本,必须
Plugin 'VundleVim/Vundle.vim'
" 请将安装插件的命令放在vundle#begin和vundle#end之间.
" Github上的插件
" 格式为 Plugin '用户名/插件仓库名'
""Plugin 'tpope/vim-fugitive'
""Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/taglist.vim'
Plugin 'Yggdroot/indentLine'
""Plugin 'vim-scripts/cscope.vim'
""Plugin 'vim-scripts/OmniCppComplete'
""Plugin 'vim-scripts/winmanager'
Plugin 'scrooloose/nerdtree'
""Plugin 'vim-scripts/minibufexplorerpp'
""Plugin 'jlanzarotta/bufexplorer'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
call vundle#end()            " 必须
filetype plugin indent on " 必须 加载vim自带和插件相应的语法和文件类型相关脚本
"================================================================================"
""vim-airline-themes setting
let g:airline_theme="luna"
"indentLine"
""let g:indentLine_setColors = 0
let g:indentLine_char = '¦'
let g:indentLine_enaled = 1

""let g:airline_theme="solarized"
"nmap <Leader>tb :TagbarToggle<CR>		"快捷键设置
""let g:tagbar_ctags_bin='ctags'			"ctags程序的路径
""let g:tagbar_width=30					"窗口宽度的设置
"map <F3> :Tagbar<CR>
"========================================================================================"
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()	"如果是c语言的程序的话，tagbar自动开启
""let NERDTreeWinPos='right'
let NERDTreeWinSize=30
map <F4> :NERDTreeToggle<CR>
""autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
"========================================================================================="
"""""""""taglist
let Tlist_Ctags_Cmd='/usr/bin/ctags'
""""Tlist_WinHeight
""""Tlist_Winweight
""""Tlist_Sort_Type=name
let Tlist_Compact_Format = 1
""When open taglist,cursor on taglist'window
let Tlist_GainFocus_On_ToggleOpen = 1
""""close the taglist after selete tag
let Tlist_Close_On_Select = 1	
""""display on right
let Tlist_Use_Right_Window = 1
""only display currently file's taglist
let Tlist_Show_One_File = 1
let Tlist_Show_Menu = 1
""""If taglist is lastly window,quit to vim 
let Tlist_Exit_OnlyWindow = 1
let Tlist_Process_File_Alway=1
""let Tlist_Auto_Open = 1
nnoremap <C-l> :TlistToggle<CR>
"============================================================="
"""""""""""ctags setting
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR> 
set tags=tags;
"============================================================="
""""""""cscope setting
""set cscopequickfix=s-,c-,d-,i-,t-,e-
""""""""omnicppcomplete
""let OmniCpp_NamespaceSearch = 1
""let OmniCpp_GlobalScopeSearch = 1
""let OmniCpp_ShowAccess = 1
""let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
""let OmniCpp_MayCompleteDot = 1   " 输入 .  后自动补全
""let OmniCpp_MayCompleteArrow = 1 " 输入 -> 后自动补全
""let OmniCpp_MayCompleteScope = 1 " 输入 :: 后自动补全
""let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" 自动关闭补全窗口
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest
"===================End=========================================="
