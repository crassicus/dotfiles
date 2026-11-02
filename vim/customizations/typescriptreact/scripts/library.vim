vim9script

def ImportFrom(pattern: string, is_type: string = "false"): void
  var type: bool = is_type == 'true'

  var absolute_pattern: string
  var insertion: string

  if type
    absolute_pattern = $"^import type {{ .* }} from \"{pattern}\";$"
    insertion =  "normal! i" .. $"import type {{  }} from \"{pattern}\";"
  else
    absolute_pattern = $"^import {{ .* }} from \"{pattern}\";$"
    insertion =  "normal! i" .. $"import {{  }} from \"{pattern}\";"
  endif

  var current_line = 1
  var last_line = line("$")

  # First look for the import pattern
  while current_line < last_line
    var content = getline(current_line)

    if match(content, absolute_pattern) != -1
      cursor(current_line, 1)
      exec "normal! f}hi, \<right>" | startinsert | return
    endif

    current_line += 1
  endwhile

  # In case the first one failed, look for function or an empty spot
  current_line = 1
  while current_line < last_line
    var content = getline(current_line)

    if match(content, 'function \|interface ') != -1
      cursor(current_line, 1)
      execute "normal! O"
      execute insertion .. "\<cr>"
      execute "normal! kf}h" | startinsert | return
    endif

    if empty(content)
      cursor(current_line, 1)
      execute insertion .. "\<cr>"
      execute "normal! kf}h" | startinsert | return
    endif

    current_line += 1
  endwhile

  echo "Failed to create import statement"
enddef

autocmd FileType typescriptreact,typescript
      \ command! -nargs=+ ImportFrom
      \ call ImportFrom(<f-args>)


export def ImportComponent(url: string): void
  var line = 1

  var content = ""
  while true
    content = getline(line)
    if empty(content) || content =~ 'function \u' | break | endif
    line = line + 1
  endwhile

  var tail = split(url, '/')[-1]
  var text = $'import {{  }} from "@/components/{url}/{tail}";'

  if content =~ 'function \u'
    append(line - 1, text) | append(line, '') | cursor(line, 0)
  endif

  if empty(content)
    append(line - 1, text) | cursor(line, 0)
  endif

  execute "normal! f}i" | startinsert | return
enddef
autocmd FileType typescriptreact
      \ command! -nargs=+ -complete=customlist,CompleteComponents ImportComponent
      \ call ImportComponent(<f-args>)


# ---------------------------------------------------------
# both functions below make possible to have suggestions
# when importing a component
# ---------------------------------------------------------
def ComponentsPath(): string
  var file = system($"sniffer package.json")
  if v:shell_error != 0 | echoerr file | return "" | endif

  file = trim(file)
  var content = readfile(file)->join("\n")

  if content =~ '@react-router/serve'
      return fnamemodify(file, ':h') .. '/app/components'
  elseif content =~ 'next'
      return fnamemodify(file, ':h') .. '/app/components'
  elseif content =~ 'react'
      return fnamemodify(file, ':h') .. '/src/components'
  endif

  return ""
enddef

def CompleteComponents(ArgLead: string, CmdLine: string, CursorPos: number): list<string>
  const root = ComponentsPath()
  if root == "" | return [] | endif

  var entries = globpath(root, '**/*', false, true)
  var folders = entries->filter((_, d) => isdirectory(d))
  folders = folders->map((_, p) => p[len(root) + 1 : ])

  return folders->filter((_, v) => v =~ '^' .. ArgLead)
enddef


defcompile
