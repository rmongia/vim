" Vim Profile
" Author: Ramandeep Singh <mongia.ramandeep@gmail.com>

" Install plugins
execute pathogen#infect()

" Syntax highlighting
syntax on

" Common indentation options
filetype indent on
filetype plugin indent on
set sw=2 ts=2 ai ci et
autocmd FileType gitcommit setlocal autoindent ts=2

" CIndent options
" Set (\n -> <current indent +2>
" Set to u0 for <current location of (>
" g0 -> public/private with no indent
" N-s -> no indent for namespace
set cinoptions=(0,u0,g0,N-s,W1s

" Comments
set comments=:///,://

" Error highlighting
:au BufRead,BufNewFile * highlight NoSpace ctermbg=red guibg=red
:au BufRead,BufNewFile * 2match NoSpace /\(\<for\>\|\<if\>\)(/
:au BufRead,BufNewFile * 2match NoSpace /\(( !\)/
:au BufRead,BufNewFile * 2match NoSpace /\s\+$/
:au BufRead,BufNewFile * 2match ErrorMsg "\%>80v.\+"

" Delete trailing whitespaces
:au BufWritePre *.proto,*.cpp,*.py,*.h,*.c :%s/\s\+$//e

" Search highlight
set hlsearch
highlight Search  ctermbg=0 ctermfg=1

" Python syntax cleanup (F8 for inplace cleanup)
let g:autopep8_indent_size=2
let g:autopep8_disable_show_diff=1

" User defined variables
let g:project_root="/home/rmongia/kido"

" Color schema
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="normal"
let g:solarized_visibility="high"
colorscheme solarized

" TagBar
let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>
nnoremap <silent> <F9> :TagbarToggle<CR>

" Cscope
function! UpdateDB()
  let l_Change2Root = system ('cd /') . "\n"
  let l_FindOut = system ('find $VIEW_ROOT -iname "*.py" -o -iname "*.proto" -o -iname "*.c" -o -iname "*.cpp" -o -iname "*.h" -o -iname "*.hpp" > $VIEW_ROOT/cscope.files') . "\n"
  let l_CSOUt = system ('cscope -b -i $VIEW_ROOT/cscope.files -f $VIEW_ROOT/cscope.out') . "\n"
  :cs reset
endfunction
command! UpdateDB :call UpdateDB()
if filereadable('$VIEW_ROOT/cscope.out')
    cs add $VIEW_ROOT/cscope.out
endif

" CtrlP
let g:ctrlp_working_path_mode = 'ra'
let g:ctrl_map = '<c-s-p>'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*/build_vg/*,*/build/*,*.a,*.o
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](build_vg|build|(\.(git|hg|svn)))$',
  \ 'file': '\v\.(so|cmake)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" Ctags
" noremap <C-F12> :UpdateTags -R $VIEW_ROOT
let g:easytags_auto_update=0
let g:easytags_on_cursorhold=0
let g:easytags_always_enabled=0
let g:easytags_dynamic_files=1

" Coding
inoremap <F2> <C-o>:w!<CR>
noremap <F2> :w!<CR>
inoremap <F3> <ESC>:
noremap <F3> :

" YCM
let g:ycm_auto_trigger = 1
" let g:ycm_min_num_of_chars_for_completion = 0
" let g:ycm_key_invoke_completion = '<C-TAB>'
" let g:ycm_key_list_select_completion = ['<C-TAB>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-A-TAB>', '<Up>']
let g:ycm_extra_conf_globlist = ['~/*']
" let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_collect_identifiers_from_tags_files = 0
