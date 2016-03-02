" mark syntax errors with :signs
let g:syntastic_enable_signs=1
" automatically jump to the error when saving the file
let g:syntastic_auto_jump=0
" don't care about warnings
let g:syntastic_quiet_messages = {'level': 'warnings'}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" always stick any detected errors into the |location-list|
let g:syntastic_always_populate_loc_list = 1
" error window will be automatically closed when no errors are detected, but not opened automatically
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
" don't run the syntax check on save+quit
let g:syntastic_check_on_wq = 0
" runs all checkers that apply to the current filetype,
" then aggregates errors found by all checkers and displays them.
let g:syntastic_aggregate_errors = 1
