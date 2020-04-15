"
" Defines the plugin map <buffer>pings
" They will be defined only when this file is autoloaded
"
nnoremap <buffer> <silent> <Plug>phpactorExtractExpression
    \ :set opfunc=phpactor#ExtractExpression<CR>g@
xnoremap <buffer> <silent> <Plug>phpactorExtractExpression
    \ :<C-U>call phpactor#ExtractExpression(visualmode())<CR>

nnoremap <buffer> <silent> <Plug>phpactorExtractConstant
    \ :call phpactor#ExtractConstant()<CR>

nnoremap <buffer> <silent> <Plug>phpactorExtractMethod
    \ :set opfunc=phpactor#ExtractMethod<CR>g@
xnoremap <buffer> <silent> <Plug>phpactorExtractMethod
    \ :<C-U>call phpactor#ExtractMethod(visualmode())<CR>

nnoremap <buffer> <silent> <Plug>phpactorImportUseStatement
    \ :call phpactor#UseAdd()<CR>

nnoremap <buffer> <silent> <Plug>phpactorGotoDefinition
    \ :call phpactor#GotoDefinition()<CR>
nnoremap <buffer> <silent> <Plug>phpactorGotoDefinitionVsplit
    \ :call phpactor#GotoDefinitionVsplit()<CR>
nnoremap <buffer> <silent> <Plug>phpactorGotoDefinitionHsplit
    \ :call phpactor#GotoDefinitionHsplit()<CR>
nnoremap <buffer> <silent> <Plug>phpactorGotoDefinitionTab
    \ :call phpactor#GotoDefinitionTab()<CR>

nnoremap <buffer> <silent> <Plug>phpactorContextMenu
    \ :call phpactor#ContextMenu()<CR>

nnoremap <buffer> <silent> <Plug>phpactorNavigate
    \ :call phpactor#Navigate()<CR>

nnoremap <buffer> <silent> <Plug>phpactorTransform
    \ :call phpactor#Transform()<CR>

nnoremap <buffer> <silent> <Plug>phpactorClassExpand
    \ :call phpactor#ClassExpand()<CR>

nnoremap <buffer> <silent> <Plug>phpactorHover
    \ :call phpactor#Hover()<CR>


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

" vim: et ts=4 sw=4 fdm=marker
