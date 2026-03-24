vim9script

import "../../general/scripts.vim" as gen
import "./extras.vim" as extras


# ------------------------------------------------
# Inserts or updates an ES6-style import statement
# for a given module. It got to be a structure and
# not a type
# ------------------------------------------------
export def ImportStructureFrom(pattern: string): void
  cursor(line("$"), 1)
  var regex_line = $"import {{ .* }} from \"{pattern}\";$"
  var result = gen.SearchUpwards([regex_line])

  if result == 0
      execute "normal! f}\<left>i, \<right>"
      startinsert
      return
  endif

  cursor(line("$"), 1)
  var multi_regex = $"^\} from \"{pattern}\";$"
  result = gen.SearchUpwards([multi_regex])

  if result == 0
    var import_ = extras.RegexFinder("^import {")
    var import_type = extras.RegexFinder("^import type {")
    var closest_upwards = max([import_, import_type])

    if closest_upwards == import_
        execute "normal! O" .. repeat("\<space>", 1)
        startinsert
        return

    else
      cursor(closest_upwards, 1)
      var sub_result = gen.SearchUpwards([multi_regex])

      if sub_result == 0
        execute "normal! O" .. repeat("\<space>", 1)
        startinsert
        return
      endif

    endif

  endif

  var import_statement = $"import {{  }} from \"{pattern}\";"
  var current_line = 1
  while !empty(getline(current_line))
      current_line += 1
  endwhile

  cursor(current_line, 1)
  execute "normal! i" .. import_statement .. "\<cr>\<esc>\<up>f}\<left>"
  startinsert
enddef
autocmd FileType typescriptreact command! -nargs=1 ImportStructureFrom call ImportStructureFrom(<f-args>)

# ------------------------------------------------
# Inserts or updates an ES6-style import statement
# for a given module. It got to be a type and
# not a structure
# ------------------------------------------------
export def ImportTypeFrom(pattern: string): void
  # Place the cursor in last row
  cursor(line("$"), 1)

  # Try first approach
  var regex_line = $"^import type {{ .* }} from \"{pattern}\";$"
  var result = gen.SearchUpwards([regex_line])
  if result == 0
    execute "normal! f\}\<left>i, \<right>"
    startinsert
    return
  endif

  # Try second approach
  cursor(line("$"), 1)
  regex_line = $"^\} from \"{pattern}\";$"
  result = gen.SearchUpwards([regex_line])

  if result == 0
    var import_ = extras.RegexFinder("^import {")
    var import_type = extras.RegexFinder("^import type {")
    var closest_upwards = max([import_, import_type])

    # Means it is an `import type` indeed
    if closest_upwards == import_type
      execute "normal! O" .. repeat("\<space>", 1)
      startinsert
      return

    else
      # Searches upwards again
      cursor(closest_upwards, 1) # move the cursor upwards
      result = gen.SearchUpwards([regex_line])
      if result == 0
        execute "normal! O" .. repeat("\<space>", 1)
        startinsert
        return
      endif
    endif

  endif

  # When import statement doesn't exist yet
  var import_statement = $"import type {{  }} from \"{pattern}\";"
  execute "normal! gg}o" .. import_statement .. "\<esc>F}\<left>"
  startinsert

enddef
autocmd FileType typescriptreact command! -nargs=1 ImportTypeFrom call ImportTypeFrom(<f-args>)
