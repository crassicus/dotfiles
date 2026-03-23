vim9script

import "../../general/scripts.vim" as gen

# ------------------------------------------------
#  Creates a React/NextJS component at src/components
# ------------------------------------------------
def CreateReactComponent(components: list<string>)
  g:components = components
  py3 << EOF

from stacker import create_component

initial_position = vim.eval("expand('%:p')")

for component in vim.eval("g:components"):
  try:
      create_component(component)
  except Exception as e:
      print("{}".format(e))

EOF
unlet g:components
enddef
autocmd FileType typescriptreact command! -nargs=* CreateComponent call CreateReactComponent([<f-args>])


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


# ------------------------------------------------
# Add `ClassName` attribute, in case it's already
# there, it places the cursor at the end of the
# string holding the class
# ------------------------------------------------
def AddClassName()
  var line_content = getline(".")

  var condition = "className=\".*\""
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
    execute "normal! iclassName=\"\""
    startinsert
    return
  endif

  condition = "[^=<]>"
  matches = match(line_content, condition)
  if matches != -1
    execute "normal! 0/[^=]>\<cr>a\<space>className=\"\""
    startinsert
    return
  endif

  echo "💥 <> pattern not found."
enddef
autocmd FileType typescriptreact command! -nargs=0 AddClassName call AddClassName()


# ------------------------------------------------
# Creates a css file for the component this function
# is called from
# ------------------------------------------------
def AddComponentCss()
  var absolute_path = expand("%:p")

  # Change extension from .tsx to .css
  var css_file = fnamemodify(absolute_path, ":r") .. ".module.css"

  # Creates CSS file
  writefile([], css_file)

  # CSS file name
  var name = fnamemodify(absolute_path, ":t")

  var import_statement = $"import \"./{name}\";"

  var view = winsaveview()
  var current_line = 1
  while !empty(getline(current_line))
      current_line += 1
  endwhile

  cursor(current_line, 1)
  execute "normal! i" .. import_statement
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
        fnamemodify(current_file_path, ":r") .. ".module.css"

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


  #echo $"{complete_file_name}"
  if filereadable(complete_file_name)
    execute $"silent edit {complete_file_name}"
    redraw | echo $"{message}"
  else
    echo $"{complete_file_name} doesn't exists."
  endif

enddef
autocmd FileType typescriptreact,css command! -nargs=* ToggleTsxToCss call ToggleTsxToCss()

# ------------------------------------------------
# Change buffer to principal component
# In React          -> src/App.tsx
# In Nextjs         -> src/app/page.tsx
# ------------------------------------------------
def GoToMainComponent(): void
  py3 << EOF

from forge import find_root_directory
from pathlib import Path

try:
    current_file_parent_directory = vim.eval("expand('%:p:h')")
    root_directory = find_root_directory(
        Path(current_file_parent_directory),
        "package.json",
    )
    react_app_tsx = root_directory / Path("src/App.tsx")
    react_router_root_tsx = root_directory / Path("app/root.tsx")

    if react_app_tsx.exists():
      vim.command(f"silent edit {react_app_tsx}")
    elif react_router_root_tsx.exists():
      vim.command(f"silent edit {react_router_root_tsx}")
    else:
      vim.command("echo 'Neither a React nor a React Router app.'")

except Exception as e:
    vim.command(f"echo '{e}'")
EOF
enddef
autocmd FileType typescriptreact,css command! -nargs=* GoToMainComponent call GoToMainComponent()


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
