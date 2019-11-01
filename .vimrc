" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|

let mapleader =" "
set runtimepath+=/.config/nvim/autoload/Vundle.vim

call plug#begin('~/.config/nvim/plugged')

	Plug 'PotatoesMaster/i3-vim-syntax'
	Plug 'jreybert/vimagit'
	Plug 'LukeSmithxyz/vimling'
	Plug 'vimwiki/vimwiki'
	Plug 'junegunn/goyo.vim'
	" Plug 'rafi/awesome-vim-colorschemes'
	Plug 'crusoexia/vim-monokai'
	Plug 'Yggdroot/indentLine'
	Plug 'rhysd/vim-clang-format', { 'for': 'cpp' }
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	Plug 'christoomey/vim-titlecase'
	Plug 'christoomey/vim-sort-motion'
	Plug 'christoomey/vim-system-copy'
	Plug 'jiangmiao/auto-pairs'
	Plug 'vim-airline/vim-airline'
	Plug 'scrooloose/nerdtree'
	Plug 'vim-scripts/ReplaceWithRegister'
	Plug 'Valloric/YouCompleteMe', { 'for': 'cpp' }
	Plug 'rdnetto/YCM-Generator', { 'branch': 'stable', 'for': 'cpp' }
	Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }

call plug#end()

if has('nvim')
	set runtimepath+=/usr/share/vim/vimfiles
endif
" set runtimepath^=~/.vim/bundle/ctrlp.vim

" Some basics:
	color monokai
	autocmd FileType cpp color monokai
	autocmd FileType cpp set cursorline
    autocmd FileType cpp packadd termdebug
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
	" set cc=80
	" set textwidth=78
	set wrap
	set tabstop=4
	set shiftwidth=4
	set expandtab
	set softtabstop=4

" Enable autocompletion:
	set wildmode=longest,list,full
" YCM settings
	let g:ycm_complete_in_comments=1		" turn on completion in comments
	let g:ycm_confirm_extra_conf=0	 		" load ycm conf by default
	let g:ycm_collect_identifiers_from_tags_files=1 " turn on tag completion
	set completeopt-=preview 			" only show completion as a list instead of a sub-window
	let g:ycm_min_num_of_chars_for_completion=1 	" start completion from the first character
	let g:ycm_cach_omnifunc=1 			" don't cache completion items
	let g:ycm_seed_identifiers_with_syntax=1 	" complete syntax keywords
	let g:ycm_enable_diagnostic_signs=1
	" highlight YcmErrorLine guibg=#000000
	" highlight YcmErrorSign guibg=#777700
	highlight YcmErrorSection guibg=#840505

    nnoremap <leader>yfi :YcmCompleter FixIt 1<enter>

" Clang formatting settings for c++
	" let g:clang_format#code_style="WebKit"
	let g:clang_format#auto_format_on_insert_leave=1
	let g:clang_format#auto_format=1
    " let g:clang_format#style_options = {
    "             \ "BreakBeforeBraces" : "Stroustrup",
    "             \ "BraceBreakingStyle" : "BS_Allman",
    "             \ "Standard" : "C++11"}

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Open nerdtree
	map <C-n> :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitright splitbelow

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Gets rid of highlighting after you are finished searching
	map <space><space> :w<enter> $$ :let @/=""<enter>
	" map <space><space> :let @/=""<enter>

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>

" Makes a vertical split
	map <leader>t :vsp<CR>

" Opens vimrc
	map <leader>v :vsp ~/.vimrc<CR>

" Open my bibliography file in split
	map <leader>b :vsp<space>$BIB<CR>
	map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR><CR>
" With only one <CR> it propts for input before exiting the buffer

" It's supposed to execute a compiled program
	map <leader>x :!st -e "expand('%:r') & '.o'"

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex
	autocmd BufRead,BufNewFile *.?pp set filetype=cpp

" Readmes autowrap text:
	autocmd BufRead,BufNewFile *.md set tw=79

" Use urlscan to choose and open a url:
	:noremap <leader>u :w<Home> !urlscan -r 'linkhandler {}'<CR>
	:noremap ,, !urlscan -r 'linkhandler {}'<CR>

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
	vnoremap <C-c> "+y
	map <C-p> "+P

" Enable Goyo by default for mutt writting
	" Goyo's width will be the line limit in mutt.
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost ~/.bm* !shortcuts

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb %

" Navigating with guides
	" inoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
	vnoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
	map <Space><Tab> <Esc>/<++><Enter>"_c4l

" expands brackets
	" inoremap {<Enter> <Esc>$a<Enter>{<Esc>o}<Esc>O

 "____        _                  _
"/ ___| _ __ (_)_ __  _ __   ___| |_ ___
"\___ \| '_ \| | '_ \| '_ \ / _ \ __/ __|
 "___) | | | | | |_) | |_) |  __/ |_\__ \
"|____/|_| |_|_| .__/| .__/ \___|\__|___/
              "|_|   |_|

"""LATEX
	" Word count:
	autocmd FileType tex map <leader><leader>o :w !detex \| wc -w<CR>

	" Code snippets
	autocmd FileType tex inoremap ,ra {}<++><esc>T{i
	autocmd FileType tex inoremap ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
	autocmd FileType tex inoremap ,fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ,exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ,em \emph{}<++><Esc>T{i
	autocmd FileType tex inoremap ,bf \textbf{}<++><Esc>T{i
	autocmd FileType tex vnoremap , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
	autocmd FileType tex inoremap ,it \textit{}<++><Esc>T{i
	autocmd FileType tex inoremap ,ct \textcite{}<++><Esc>T{i
	autocmd FileType tex inoremap ,cp \parencite{}<++><Esc>T{i
	autocmd FileType tex inoremap ,glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
	autocmd FileType tex inoremap ,x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
	autocmd FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ,li <Enter>\item<Space>
	autocmd FileType tex inoremap ,ref \ref{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
	autocmd FileType tex inoremap ,ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
	autocmd FileType tex inoremap ,can \cand{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,con \const{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,v \vio{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,a \href{}{<++>}<Space><++><Esc>2T{i
	autocmd FileType tex inoremap ,sc \textsc{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,st <Esc>F{i*<Esc>f}i
	autocmd FileType tex inoremap ,beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
	autocmd FileType tex inoremap ,up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex nnoremap ,up /usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex inoremap ,tt \texttt{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,bt {\blindtext}
	autocmd FileType tex inoremap ,nu $\varnothing$
	autocmd FileType tex inoremap ,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
	autocmd FileType tex inoremap ,rn (\ref{})<++><Esc>F}i

