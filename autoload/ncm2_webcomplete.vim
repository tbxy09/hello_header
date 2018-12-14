if get(s:, 'loaded', 0)
    finish
endif
let s:loaded = 1

let g:ncm2_helloheader_enabled = get(g:, 'ncm2_helloheader_enabled',  1)

let g:ncm2_helloheader_script = get(g:, 'ncm2_helloheader_script',
			\ expand('<sfile>:h:h') . "/sh/cattocwords")

let g:ncm2_helloheader#proc = yarp#py3('ncm2_helloheader')

let g:ncm2_helloheader#source = get(g:, 'ncm2_helloheader#source', {
            \ 'name': 'web',
            \ 'priority': 6,
            \ 'mark': 'web',
            \ 'on_complete': 'ncm2_helloheader#on_complete',
            \ 'on_warmup': 'ncm2_helloheader#on_warmup'
            \ })

let g:ncm2_helloheader#source = extend(g:ncm2_helloheader#source,
            \ get(g:, 'ncm2_helloheader#source_override', {}),
            \ 'force')

function! ncm2_helloheader#init()
    call ncm2#register_source(g:ncm2_helloheader#source)
endfunction

function! ncm2_helloheader#on_warmup(ctx)
    call g:ncm2_helloheader#proc.jobstart()
endfunction

function! ncm2_helloheader#on_complete(ctx)
    let s:is_enabled = get(b:, 'ncm2_helloheader_enabled',
                \ get(g:, 'ncm2_helloheader_enabled', 1))
    if ! s:is_enabled
        return
    endif
    call g:ncm2_helloheader#proc.try_notify('on_complete', a:ctx)
endfunction
