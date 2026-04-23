vim9script

# ------------------------------------------------
# Searches for a regex pattern in the current file
# starting from the current line and moving upwards.
#
# Returns the line number where the pattern is found
# and -1 otherwise
# ------------------------------------------------
export def RegexFinder(regex: string): number
  var line_number = line(".")

  while line_number > 0
    var line_content = getline(line_number)

    # If regex pattern was found on the line.
    if match(line_content, regex) != -1
      return line_number
    endif

    line_number -= 1
  endwhile

  return -1
enddef


export def Write(method: string): string
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

    if method == "component"
        var lines = [
            \ 'function X() {',
            \ 'return <div>Hello Component</div>',
            \ '}',
            \ '',
            \ 'export default X;',
        ]
        return join(lines, "\n")
    endif

    if method == "callback_component"
        var lines = [
            \ 'const  = () => {',
            \ 'return <div>Hello Component</div>',
            \ '}',
        ]
        return join(lines, "\n")
    endif

    return ""
enddef

defcompile
