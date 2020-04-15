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

" vim: et ts=4 sw=4 fdm=marker
