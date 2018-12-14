let s:script = expand('<sfile>:h:h') . "/sh/cattocwords"

function! helloheader#complete(findstart, base)
  if a:findstart
    return helloheader#findstart()
  else
    return helloheader#completions(a:base)
  endif
endfunction

function! helloheader#findstart()
  let line = getline('.')
  let start = col('.') - 1

  while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
  endwhile

  return start
endfunction

function! helloheader#completions(base)
  let command  =  'sh ' . shellescape(s:script)
  let command .= '| grep ' . shellescape(a:base)

  let completions = system(command)

  if v:shell_error != 0
      return []
  endif

  return split(completions, '\n')
endfunction
