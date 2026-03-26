vim9script
import "../general/scripts.vim" as gen


# ------------------------------------------------
# Toggle export statement
# ------------------------------------------------
def TsAddExport(): void
    var view = winsaveview()

    var patterns = 'function \|interface \|enum \|class \|type '
    var current_line = line(".")

    while current_line > 1
        var content = getline(current_line)
        if match(content, patterns) != -1
            cursor(current_line, 1)

            if match(content, '^export ') != -1
                execute "normal! dW"
                winrestview(view) | return
            endif

            execute "normal! iexport "
            winrestview(view) | return

        endif
        current_line -= 1
    endwhile

    echo "Failed to find pattern to add export statement."

enddef
autocmd FileType typescript
      \ command! -nargs=0 TsAddExport
      \ call TsAddExport()


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
