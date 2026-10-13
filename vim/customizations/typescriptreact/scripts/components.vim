vim9script

import "../../general/scripts.vim" as gen


# ---------------------------------------------------------
# Generate a ReactJS or NextJs component
# ---------------------------------------------------------
def CreateComponent(components: list<string>)
  var cmps = join(components, ' ')
  echo system($"uxie component {cmps}")
enddef

autocmd FileType typescriptreact
  \ command! -nargs=* CreateComponent call CreateComponent([<f-args>])


# ------------------------------------------------
#  Creates a NextJS page at src/app
# ------------------------------------------------
def CreateRoute(routes: list<string>)
  g:routes = routes
  py3 << EOF

from stacker import create_route

initial_position = vim.eval("expand('%:p')")

for route in vim.eval("g:routes"):
  try:
      create_route(route)
  except Exception as e:
      print("{}".format(e))

EOF
unlet g:routes
enddef
autocmd FileType typescriptreact command! -nargs=* CreateRoute call CreateRoute([<f-args>])


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


# ------------------------------------------------
# Place the cursor to add an attribute into
# current tag
# ------------------------------------------------
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

  echo "💥 <> pattern not found."
enddef
autocmd FileType typescriptreact command! -nargs=* AddAttribute call AddAttribute()


# ---------------------------------------------------------
# Add `className` attribute with custom logic
# ---------------------------------------------------------
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

  match_position = match(line_content, '\v(\=)@<!\>')
  if match_position != -1
    echo match_position
    cursor(line("."), match_position + 1)
    exe "normal! i\<space>className=\<space>" | startinsert | return
  endif

  echo "add classname: failed to find a valid pattern."
enddef
autocmd FileType typescriptreact command! -nargs=0 AddClassName call AddClassName()


# ------------------------------------------------
# Creates a css file for the component this function
# is called from
# ------------------------------------------------
def AddComponentCss()
  var absolute_path = expand("%:p")

  # Read file and extract random class
  var content = join(readfile(absolute_path), "\n")
  var random_class = matchstr(content, 'className="\zs[^"]\+\ze"')

  # Change extension from .tsx to .css
  var css_file = fnamemodify(absolute_path, ":r") .. ".css"

  # Creates CSS file
  var css_content = $"@scope (.{random_class}) {{}}"
  writefile([css_content], css_file)

  # CSS file name
  var name = fnamemodify(css_file, ":t")

  var import_statement = $"import \"./{name}\";"

  var view = winsaveview()
  var current_line = 1
  while !empty(getline(current_line))
      current_line += 1
  endwhile

  cursor(current_line, 1)
  execute "normal! i" .. import_statement .. "\<cr>"
  winrestview(view)

enddef


# ------------------------------------------------
# Takes the cursor to the component's parameters
# position
# ------------------------------------------------
def JumpToComponentHead()
  var result = gen.SearchUpwards(['function\s\u\w*'])

  # If pattern was not found upwards search downwards.
  if result != 0
    result = gen.SearchDownwards(['function\s\u\w*'])
  endif

  # Means pattern was found and cursor is in target line
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


# ------------------------------------------------
# Switch to component css if it exists
# ------------------------------------------------
def ToggleTsxToCss()
  var current_file_path = expand("%:p")

  # Get file extension
  var extension = fnamemodify(current_file_path, ":e")

  var complete_file_name = ""
  var message = ""

  if extension == "tsx"
      complete_file_name =
        fnamemodify(current_file_path, ":r") .. ".css"

      # Create the CSS file if doesn't exist yet
      if !filereadable(complete_file_name)
        var css_file_name = fnamemodify(complete_file_name, ":t")
        var answer = input($"{css_file_name} file is being created, " ..
             "do you want to continue (y/n): "
        )
        if answer !=# "y" | redraw! | return | endif

        AddComponentCss()
        message = execute("messages")->split("\n")[-1]
      endif
  else
      complete_file_name = fnamemodify(current_file_path, ":r:r") .. ".tsx"
  endif


  if filereadable(complete_file_name)
    execute $"silent edit {complete_file_name}"
    redraw | echo $"{message}"
  else
    echo $"{complete_file_name} doesn't exists."
  endif

enddef
autocmd FileType typescriptreact,css command! -nargs=* ToggleTsxToCss call ToggleTsxToCss()


# ------------------------------------------------
# Jumps to the tag content and enters insert mode
# ------------------------------------------------
def EditAfterTag(): void
  if getline(".") =~ "<.*>.*<\/.*>"
    exec "silent normal! 0/<\\/\<cr>"
    exec "silent normal! cT>\<esc>\<right>"
    startinsert
  endif
enddef
autocmd FileType typescriptreact command! -nargs=* EditAfterTag call EditAfterTag()

# ------------------------------------------------
# Compile functions
# ------------------------------------------------
defcompile
