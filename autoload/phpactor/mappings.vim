function! phpactor#mappings#exists(lhs, mode)
    return !empty(maparg(a:lhs, a:mode))
endfunction

function! phpactor#mappings#map(lhs, rhs, modes, ...)
    let modes = split(a:modes, '|')
    let force = 0 < a:0 ? a:1 : v:false

    for mode in modes
        if force || !phpactor#mappings#exists(a:lhs, mode)
            " Declare mappings to the buffer only
            " Since they are for a specific language
            " It leave some space for other language mappings
            silent execute mode .'map <buffer> '. a:lhs .' '. a:rhs
        endif
    endfor
endfunction


"
" Defines the plugin mappings
" They will be defined only when this file is autoloaded
"
nnoremap <silent> <Plug>phpactorExtractExpression
    \ :set opfunc=phpactor#ExtractExpression<CR>g@
xnoremap <silent> <Plug>phpactorExtractExpression
    \ :<C-U>call phpactor#ExtractExpression(visualmode())<CR>

nnoremap <silent> <Plug>phpactorExtractConstant
    \ :call phpactor#ExtractConstant()<CR>

nnoremap <silent> <Plug>phpactorExtractMethod
    \ :set opfunc=phpactor#ExtractMethod<CR>g@
xnoremap <silent> <Plug>phpactorExtractMethod
    \ :<C-U>call phpactor#ExtractMethod(visualmode())<CR>

nnoremap <silent> <Plug>phpactorImportUseStatement
    \ :call phpactor#UseAdd()<CR>

nnoremap <silent> <Plug>phpactorGotoDefinition
    \ :call phpactor#GotoDefinition()<CR>
nnoremap <silent> <Plug>phpactorGotoDefinitionVsplit
    \ :call phpactor#GotoDefinitionVsplit()<CR>
nnoremap <silent> <Plug>phpactorGotoDefinitionHsplit
    \ :call phpactor#GotoDefinitionHsplit()<CR>
nnoremap <silent> <Plug>phpactorGotoDefinitionTab
    \ :call phpactor#GotoDefinitionTab()<CR>

nnoremap <silent> <Plug>phpactorContextMenu
    \ :call phpactor#ContextMenu()<CR>

nnoremap <silent> <Plug>phpactorNavigate
    \ :call phpactor#Navigate()<CR>

nnoremap <silent> <Plug>phpactorTransform
    \ :call phpactor#Transform()<CR>

nnoremap <silent> <Plug>phpactorClassExpand
    \ :call phpactor#ClassExpand()<CR>

nnoremap <silent> <Plug>phpactorHover
    \ :call phpactor#Hover()<CR>


" Function to be called to initializes the mappings for every buffer
function! phpactor#mappings#init()
    " Mnemotechnic "Change into Variable"
    call phpactor#mappings#map('cv', '<Plug>phpactorExtractExpression', 'n')

    " Mnemotechnic "Change into Method"
    call phpactor#mappings#map('cm', '<Plug>phpactorExtractMethod', 'n')

    call phpactor#mappings#map('yu', '<Plug>phpactorImportUseStatement', 'n')

    if v:true == get(g:, 'phpactorActivateOverlapingMappings', v:false)
        " Visual mapping starting with `c` prevent to change a selection
        " Use `s` instead to replace a selection while the mappings are activated
        call phpactor#mappings#map('cv', '<Plug>phpactorExtractExpression', 'x')
        call phpactor#mappings#map('cm', '<Plug>phpactorExtractMethod', 'x')

        " `cc` replace the current line, use `S` instead
        " Mnemotechnic "Change into Constant"
        call phpactor#mappings#map('cc', '<Plug>phpactorExtractConstant', 'n')

        " Replaces the tags mappings
        call phpactor#mappings#map('<C-]>', '<Plug>phpactorGotoDefinition', 'n')
        call phpactor#mappings#map('<C-w>]', '<Plug>phpactorGotoDefinitionVsplit', 'n')
        call phpactor#mappings#map('<C-w><C-]>', '<Plug>phpactorGotoDefinitionVsplit', 'n')
    endif

    " Put in last to override any default mapping if needed
    for mapping in get(g:, 'phpactorCustomMappings', [])
        call call('phpactor#mappings#map', add(copy(mapping), v:true))
    endfor
endfunction

" vim: et ts=4 sw=4 fdm=marker
