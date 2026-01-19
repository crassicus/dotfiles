vim9script
# vim/customizations/svelte/scripts.vim

def ChangeTagContent(): void
  # Remove the content and place the cursor in insert mode
  # at the center of the inline tag
  if getline(".") =~ "<.*>.*<\/.*>"
    exec "silent normal! 0/<\\/\<cr>"
    exec "silent normal! cT>\<esc>\<right>"
    startinsert
  endif
enddef
autocmd FileType svelte command! -nargs=* ChangeTagContent call ChangeTagContent()


def AddClass()
  var line_content = getline(".")

  var condition = "class=\".*\""
  var matches = match(line_content, condition)
  if matches != -1
    cursor(line("."), matches + 1)
    execute "normal! 2f\""
    startinsert
    feedkeys(' ')
    return
  endif

  condition = "\/>"
  matches = match(line_content, condition)
  if matches != -1
    cursor(line("."), matches + 1)
    execute "normal! iclass=\"\""
    startinsert
    return
  endif

  condition = "[^=<]>"
  matches = match(line_content, condition)
  if matches != -1
    execute "normal! 0/[^=]>\<cr>a\<space>class=\"\""
    startinsert
    return
  endif

  echo "Failed to find tag!"
enddef
autocmd FileType svelte command! -nargs=0 AddClass call AddClass()


def AddAttribute()
  var line_content = getline(".")

  var first_approach = "[^=]\/>"
  var matching_column = match(line_content, first_approach)
  if matching_column != -1
    cursor(line("."), matching_column + 2)
    startinsert
    return
  endif

  var second_approach = "[^=]>"
  matching_column = match(line_content, second_approach)
  if matching_column != -1
    cursor(line("."), matching_column + 2)
    startinsert
    feedkeys(" ")
    return
  endif

  echo "Failed to find tag!"
enddef
autocmd FileType svelte command! -nargs=* AddAttribute call AddAttribute()



export def AddProps(): void
  var current_line_number = 1

  while current_line_number <= line("$")
    var line_content = getline(current_line_number)
    if line_content =~ "$props"
      echo "Props already exist in component"
      return
    endif
    current_line_number += 1
  endwhile

  current_line_number = line("$")
  while current_line_number > 0
    var line_content = getline(current_line_number)

    if match(line_content, $".*\} from '.*';$") != -1 ||
        match(line_content, '<script lang="ts">') != -1

      cursor(current_line_number, 1)
      execute($"normal! o{Write("props")}")
      execute($"normal! >>k>>k>>o")
      startinsert | return
    endif

    current_line_number -= 1
  endwhile

enddef
autocmd FileType svelte
      \ command! -nargs=* AddProps
      \ call AddProps()



# This function automatically finds or creates import statements
# in Svelte files for a given module pattern.
export def ImportFrom(pattern: string): void
  var regex_line_first = $"import {{ .* }} from '{pattern}';$"
  var regex_line_second = $".*\} from '{pattern}';$"
  var current_line_number = 1

  while current_line_number <= line("$")
    var line_content = getline(current_line_number)

    # Logic for when first pattern is found
    if match(line_content, regex_line_first) != -1
      cursor(current_line_number, 1)
      execute "normal! f}\<left>i, \<right>"
      startinsert | return
    endif

    # Logic for when second pattern is found
    if match(line_content, regex_line_second) != -1
      cursor(current_line_number, 1)
      execute "normal! f}kea,\<esc>jO\t\t\t"
      startinsert | return
    endif

    current_line_number += 1
  endwhile


  try
    execute(':?<script\ lang="ts">')
    execute($"normal! o\<tab>import {{  }} from '{pattern}';\<esc>F\}h")
    startinsert | return
  catch
    echo '<script lang="ts"> tag was not found'
  endtry

enddef
autocmd FileType svelte
      \ command! -nargs=1 ImportFrom
      \ call ImportFrom(<f-args>)


# Find out if the current line is inside a context defined by
# pattern[0] above and pattern[1] below
export def FindContext(pattern: list<string>): bool
  var original_line_number = line(".")
  var current_line_number = original_line_number - 1

  # Search upwards for the opening pattern (pattern[0])
  while current_line_number > 0
    var line_content = getline(current_line_number)
    if match(line_content, pattern[0]) != -1
      break
    endif
    current_line_number -= 1

  endwhile

  # Pattern[0] was not found above the current line
  if current_line_number == 0 | return false | endif

  current_line_number = original_line_number + 1

  # Search downwards for the closing pattern (pattern[1])
  while current_line_number <= line("$")
    var line_content = getline(current_line_number)
    if match(line_content, pattern[1]) != -1
      break
    endif
    current_line_number += 1
  endwhile

  # Pattern[0] was not found below the current line
  if current_line_number == line("$") + 1 | return false | endif

  return true
enddef


export def Write(method: string): string
    if method == "style"
        var lines = [
            \ '</style>',
            \ '<style>',
        ]
        return join(lines, "\n")
    endif

    if method == "script"
        var lines = [
            \ '<script lang="ts">',
            \ '</script>',
        ]
        return join(lines, "\n")
    endif

    if method == "props"
        var lines = [
            \ 'interface Props {',
            \ '}',
            \ 'let { }: Props = $props();',
        ]
        return join(lines, "\n")
    endif
    return ""
enddef


defcompile
