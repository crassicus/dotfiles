vim9script

# Typescript scripts

import "../general/scripts.vim" as gen


# Toggle export statement
# ==========================================
def TsAddExport()
    var view = winsaveview()

    var result = gen.SearchUpwards(["const", "let", "function", "class", "type", "interface", "enum"])
    var line_content = getline(".")

    # If `export` was found in current line
    if match(line_content, 'export\s') != -1
        execute "normal! ^dW"
        winrestview(view)
        return
    endif

    if result == 0
        execute "normal! Iexport "
    else
        echo "Failed to find pattern."
    endif

    winrestview(view)
enddef
autocmd FileType typescript command! -nargs=0 TsAddExport call TsAddExport()


# Compile functions
# ------------------------------------------------
defcompile
