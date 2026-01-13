vim9script

# ------------------------------------------------
# Add packages to the project
# ------------------------------------------------
def TSAddPackage(packages: list<string>): void
    g:packages = packages
    var root_folder = $ROOT

    if empty(root_folder)
        echo "<- 🧨 -> Environment variable ROOT is not set."
        return
    endif

    if empty(g:packages)
        echo "<- 🧨 -> A minimum of one package is required."
        return
    endif

    if len(g:packages) == 1 && (get(g:packages, 0) == "-D" || get(g:packages, 0) == "dev")
        echo "<- 🧨 -> A minimum of one package is required."
        return
    endif

    var connector = " add "

    if get(g:packages, 0) == "-D" || get(g:packages, 0) == "dev"
        connector = " add -D "
        remove(g:packages, 0)
    endif

    var package_managers = ["bun", "pnpm", "yarn", "npm"]
    var package_manager_ = ""

    for pkg_manager in package_managers
        if executable(pkg_manager)
            package_manager_ = pkg_manager
        endif
    endfor

    if empty(package_manager_)
        echo $"<- 🧨 -> No package manager available."
        return
    endif

    def Executer(package: string): void

        # It means connector contains `add -D` or `add dev`
        if stridx(connector, "add -D") != -1 || stridx(connector, "add dev") != -1
          echo $"<- 󱫩 -> Installing dev-dependency {package}..."
        else
          echo $"<- 󱫩 -> Installing {package}..."
        endif

        var result = system(package_manager_ .. connector .. package)

        # When a single package is being installed we clear the
        # command terminal to make it just one line
        if len(g:packages) == 1
            redraw
        endif

        # It means result contains `404` string
        if match(result, "404") != -1
            echo $"<- 🧨 -> Failed to install {package}."
        else
            echo $"<- 📦 -> Package {package} installed."
        endif

    enddef

    for package in g:packages
        Executer(package)
    endfor

    unlet g:packages
enddef
autocmd FileType typescriptreact,typescript command! -nargs=* TSAddPackage call TSAddPackage([<f-args>])


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
            \ 'function () {',
            \ 'return <>Hello Component</>',
            \ '}',
            \ '',
            \ 'export default x;',
        ]
        return join(lines, "\n")
    endif

    if method == "callback_component"
        var lines = [
            \ 'const  = () => {',
            \ 'return <>Hello Component</>',
            \ '}',
        ]
        return join(lines, "\n")
    endif

    return ""
enddef

defcompile
