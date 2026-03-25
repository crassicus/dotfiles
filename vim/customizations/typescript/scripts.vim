vim9script
import "../general/scripts.vim" as gen


# ------------------------------------------------
# Toggle export statement
# ------------------------------------------------
def TsAddExport()
    var view = winsaveview()

    var result = gen.SearchUpwards(["const", "let", "function", "class", "type", "interface", "enum"])
    var line_content = getline(".")

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


# ------------------------------------------------
# Toggle async state for the function
# ------------------------------------------------
def TSAddAsync()
    var view = winsaveview()
    var result = gen.SearchUpwards(["function"])
    var line_content = getline(".")

    if match(line_content, 'async\s') != -1
        execute "normal! :s/async\<space>//\<cr>"
        winrestview(view)
        return
    endif

    if result == 0
        execute "normal! ^fcbiasync \<esc>"
    else
        echo "Failed to find pattern."
    endif

    winrestview(view)
enddef
autocmd FileType typescript command! -nargs=0 TSAddAsync call TSAddAsync()


defcompile
