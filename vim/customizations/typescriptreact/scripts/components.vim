vim9script

import "../../general/scripts.vim" as gen


# ---------------------------------------------------------
# generate a reactjs or nextjs component
# ---------------------------------------------------------
def CreateComponent(components: list<string>)
  var cmps = join(components, ' ')
  echo system($"uxie component {cmps}")
enddef

autocmd FileType typescriptreact
  \ command! -nargs=* CreateComponent call CreateComponent([<f-args>])


# ---------------------------------------------------------
# generate a nextjs route
# ---------------------------------------------------------
def CreateRoute(routes: list<string>)
  var rs = join(routes, ' ')
  echo system($"uxie route {rs}")
enddef

autocmd FileType typescriptreact
  \ command! -nargs=* CreateRoute call CreateRoute([<f-args>])


# ------------------------------------------------
#  Add Props statement to the current component
# ------------------------------------------------
def AddProps()

  var view = winsaveview()
  var result = gen.SearchUpwards(['function\s\u\w*'])

  if result != 0
    result = gen.SearchDownwards(['function\s\u\w*'])
  endif

  if result == 0
    var current_line = line('.')
    var current_content = getline('.')
    var component_name = matchstr(current_content, 'function \zs\w\+')
    var props_name = component_name .. 'Props'
    var props_result = gen.SearchUpwards([props_name])

    if props_result == 0
      echo "The component " .. component_name "already has Props."

      winrestview(view)
      return
    endif

    execute $"normal! f)i{{  }}: {props_name}"
    execute $"normal! Ointerface {props_name} {{}}\<cr>\<up>"
    execute "normal! f}i\<cr>\<esc>O"
    startinsert
    feedkeys('  ')
    return
  endif

  echo "Props pattern was not found."
enddef
autocmd FileType typescriptreact command! -nargs=0 Props call AddProps()


# ----------------------------------------------------------
# place the cursor at the end of the tag to insert attribute
# ----------------------------------------------------------
def InsertAttribute(): void
  var line_content = getline(".")

  var match_position = match(line_content, '/>')
  if match_position != -1
    echo match_position
    cursor(line("."), match_position + 1)
    startinsert | feedkeys(' ') | return
  endif

  match_position = match(line_content, '\v(\=)@<!\>')
  if match_position != -1
    echo match_position
    cursor(line("."), match_position + 1)
    startinsert | feedkeys(' ') | return
  endif

  echo "insert tag: failed to find valid pattern"
enddef
autocmd FileType typescriptreact
  \ command! -nargs=* InsertAttribute call InsertAttribute()


# ----------------------------------------------------------
# add `className` attribute to tag with custom logic
# ----------------------------------------------------------
def AddClassName(): void
  var line_content = getline(".")

  var match_position = match(line_content, " className={cx(.*)}")
  if match_position != -1
    cursor(line("."), match_position + 1)
    exe "normal! f)i,\<space>"
    startinsert | feedkeys(' ') | return
  endif

  # return in case it's an already a multiple line class
  match_position = match(line_content, " className={cx(.*")
  if match_position != -1 | return | endif

  match_position = match(line_content, " className={.*}")
  if match_position != -1
    cursor(line("."), match_position + 1)
    exe "normal! f{ci{cx(\<esc>pli,)"
    startinsert | feedkeys(' ') | return
  endif

  match_position = match(line_content, " className=\".*\"")
  if match_position != -1
    cursor(line("."), match_position + 1)
    exe "normal! 2f\""
    startinsert | feedkeys(' ') | return
  endif

  # some tags end up with '/>'
  match_position = match(line_content, '/>')
  if match_position != -1
    echo match_position
    cursor(line("."), match_position + 1)
    exe "normal! i\<space>className=\<esc>l" | startinsert | return
  endif

  match_position = match(line_content, '\v(\=)@<!\>')
  if match_position != -1
    echo match_position
    cursor(line("."), match_position + 1)
    exe "normal! i\<space>className=\<esc>l" | startinsert | return
  endif

  echo "add classname: failed to find a valid pattern."
enddef
autocmd FileType typescriptreact command! -nargs=0 AddClassName call AddClassName()


# ---------------------------------------------------------
# creates a css file for the component this function is
# called from.
# ---------------------------------------------------------
def AddComponentCss()
  var absolute_path = expand("%:p")

  # change extension from .tsx to .module.css
  var css_file = fnamemodify(absolute_path, ":r") .. ".module.css"

  # creates css file
  writefile([], css_file)

  # css file name
  var name = fnamemodify(css_file, ":t")

  var import_statement = $"import styles from \"./{name}\";"

  var view = winsaveview()

  var line = 1
  while true
    var line_content = getline(line)

    if line_content =~ 'export function'
      append(line - 1, import_statement)
      append(line, '') |  break
    endif

    if empty(line_content)
      append(line - 1, import_statement) | break
    endif

    line = line + 1
  endwhile

  winrestview(view)
enddef


# ---------------------------------------------------------
# takes the cursor to the component's parameters position
# ---------------------------------------------------------
def JumpToComponentHead()
  var result = gen.SearchUpwards(['function\s\u\w*'])

  # if pattern was not found upwards search downwards.
  if result != 0
    result = gen.SearchDownwards(['function\s\u\w*'])
  endif

  # means pattern was found and cursor is in target line
  if result == 0
    var line_content = getline(".")

    if match(line_content, "()") != -1
      execute "norm! f)"
      return
    endif

    if match(line_content, "{}") != -1
      execute "norm! f}"
      return
    endif

    if match(line_content, "{.*}") != -1
      execute "norm! f}h"
      return
    endif

    if match(line_content, "({") != -1
      execute "norm! /)\<cr>"
      return
    endif

  endif

  echo "Failed to find pattern."
enddef
autocmd FileType typescriptreact command! -nargs=0 JumpToComponentHead call JumpToComponentHead()


# ------------------------------------------------
# Takes the cursor the component's return position
# ------------------------------------------------
def JumpToJsxReturn()
  var result = gen.SearchUpwards(["return (", "return <"])
  if result == 0 | execute "normal! ww" | return | endif

  result = gen.SearchDownwards(["return (", "return <"])
  if result == 0 | execute "normal! ww" | return | endif

  echo "Failed to find pattern."
enddef
autocmd FileType typescriptreact command! -nargs=0 JumpToJsxReturn call JumpToJsxReturn()


# ---------------------------------------------------------
# switch to component css file if it exists, otherwise
# create it.
# ---------------------------------------------------------
def ToggleTsxToCss()
  var current_file_path = expand("%:p")

  # current file extension
  var extension = fnamemodify(current_file_path, ":e")

  # it means the script is running from a tsx file
  if extension == "tsx"
    var css_file = fnamemodify(current_file_path, ":r") .. ".module.css"

    # create the css file if it doesn't exist yet
    if !filereadable(css_file)
      var css_file_name = fnamemodify(css_file, ":t")
        var answer = input(
            $"{css_file_name} file is being created, " ..
            "do you want to continue (y/n): "
        )
        if answer !=# "y" | redraw! | return | endif

        AddComponentCss()
        execute $"silent edit {css_file}" | return
    endif

    if filereadable(css_file)
      execute $"silent edit {css_file}" | return
    endif

  endif

  # it means the script is running from a css file
  if extension == "css"
    var tsx_file = fnamemodify(current_file_path, ':r:r') .. ".tsx"
    execute $"silent edit {tsx_file}"
  endif

enddef
autocmd FileType typescriptreact command! -nargs=* ToggleTsxToCss call ToggleTsxToCss()


# ------------------------------------------------
# Jumps to the tag content and enters insert mode
# ------------------------------------------------
def EditTagContent(): void
  if getline(".") =~ "<.*>.*<\/.*>"
    exec "silent normal! 0/<\\/\<cr>"
    exec "silent normal! cT>\<esc>\<right>"
    startinsert
  endif
enddef
autocmd FileType typescriptreact command! -nargs=* EditTagContent call EditTagContent()

# ------------------------------------------------
# Compile functions
# ------------------------------------------------
defcompile
