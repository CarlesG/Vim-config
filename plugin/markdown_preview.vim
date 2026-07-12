"-----------------------------------------------------------
" Markdown Preview para GVim (Windows)
" v0.2
"-----------------------------------------------------------

if exists('g:loaded_markdown_preview')
    finish
endif
let g:loaded_markdown_preview = 1
" Ruta a Pandoc
let g:pandoc = 'C:\Program Files\Pandoc\pandoc.exe'

" CSS personalizado
let g:markdown_css = expand('~/vimfiles/css/github.css')

function! s:Preview()

    if &filetype !=# 'markdown'
        return
    endif

    if !filereadable(g:pandoc)
        echohl ErrorMsg
        echom 'No se encuentra Pandoc'
        echohl None
        return
    endif

    let l:md = expand('%:p')
    let l:html = expand('%:p:r') . '.html'

    let l:cmd = '"' . g:pandoc . '"'
    let l:cmd .= ' "' . l:md . '"'
    let l:cmd .= ' --standalone'

    " HTML autocontenido
    let l:cmd .= ' --embed-resources'

    " Resaltado de código
    let l:cmd .= ' --highlight-style=pygments'

    " CSS personalizado
    if filereadable(g:markdown_css)
        let l:cmd .= ' --css="' . g:markdown_css . '"'
    endif

    let l:cmd .= ' -o "' . l:html . '"'

    call system(l:cmd)

    if v:shell_error
        echohl ErrorMsg
        echom 'Pandoc devolvió un error'
        echom l:cmd
        echohl None
        return
    endif

    if !exists('g:markdown_preview_open')
        let g:markdown_preview_open = 1
        call system('cmd /c start "" "' . l:html . '"')
    endif

    echom "HTML actualizado"

endfunction

command! MarkdownPreview call s:Preview()

augroup MarkdownPreview
    autocmd!
    autocmd BufWritePost *.md call s:Preview()
augroup END
