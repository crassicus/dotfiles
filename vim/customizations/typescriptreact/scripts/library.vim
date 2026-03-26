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

autocmd FileType typescriptreact command! -nargs=+ ImportFrom call ImportFrom(<f-args>)
