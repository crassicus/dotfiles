vim9script

# HTML scripts

export def Write(method: string): string
    if method == "scaffold"
        var lines = [
            \ '<!doctype html>',
            \ '<html lang="en">',
            \ '<head>',
            \ '<meta charset="UTF-8">',
            \ '<meta name="viewport" content="width=device-width, initial-scale=1.0">',
            \ '<title>Document</title>',
            \ '<link rel="stylesheet" href="style.css">',
            \ '</head>',
            \ '',
            \ '<body>',
            \ '<script type="module" src="script.js"></script>',
            \ '</body>',
            \ '</html>',
            \ ''
            \ ]

        return join(lines, "\n")
    endif

    if method == "table"
        var lines = [
            \ '<table>',
            \ '<thead>',
            \ '<tr>',
            \ '<th></th>',
            \ '</tr>',
            \ '</thead>',
            \ '<tbody>',
            \ '<tr>',
            \ '<td></td>',
            \ '</tr>',
            \ '</tbody>',
            \ '</table>'
        ]

        return join(lines, "\n")
    endif
    return ""
enddef

# Move the cursor before `>` to add an attribute
# ----------------------------------------------
def AddAttribute(): void
    var line_content = getline(".")
    var matching = match(line_content, '=\@<!>')

    if matching != -1
        cursor(line("."), matching + 1)
        startinsert | feedkeys(" ") | return
    endif

    echo "Cannot move cursor to add attribute: pattern not found"
enddef
autocmd FileType html,htmldjango
      \ command! -nargs=* AddAttribute
      \ call AddAttribute()


# Move the cursor after `>`, remove what's inside adn leave insert cursor
# ----------------------------------------------
def EditAfterTag(): void
    var line_content = getline(".")
    var matching = match(line_content, '<.*>.*<\/.*>')

    if matching != -1
        var right_anchor = match(line_content, '=\@<!>')
        cursor(line("."), right_anchor + 2)
        execute "normal! dt<" | startinsert | return
    endif

    echo "Cannot edit after tag: pattern not found"
enddef
autocmd FileType html,htmldjango
      \ command! -nargs=* EditAfterTag
      \ call EditAfterTag()


defcompile
