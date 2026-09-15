vim9script

# Rust scripts

# Toggle `pub` or `pub(crate)` on the nearest keyword above
# ---------------------------------------------------------
def TogglePub(): void
    var view = winsaveview()
    var current_line = line(".")

    var keywords = '\v\s?<(fn|struct|trait|enum|type)>'

    # Search upwards for any of the `keywords`
    while current_line >= 1
        var line_content = getline(current_line)
        if match(line_content, keywords) != -1
            break
        endif

        current_line -= 1
    endwhile

    # Reaching line zero means no `keyword` was found
    if current_line == 0
        echo "Cannot toggle pub: no valid keyword was found above." | return
    endif

    var line_content = getline(current_line)

    # If `pub` or `pub(crate )` is present, remove it from the current line
    if match(line_content, 'pub\s\|pub(crate)\s') != -1
        execute $':{current_line}normal! ^dW'
        winrestview(view) | return
    endif

    execute $':{current_line}normal! Ipub '

    winrestview(view)
enddef
autocmd FileType rust command! -nargs=0 TogglePub call TogglePub()


# Toggle `async` on the nearest `fn` above
# ------------------------------------------------
def ToggleAsync(): void
    var view = winsaveview()
    var current_line = line(".")

    var keywords = 'fn\s'

    # Search upwards for `fn `
    while current_line >= 1
        var line_content = getline(current_line)
        if match(line_content, keywords) != -1
            break
        endif

        current_line -= 1
    endwhile

    # Reaching line zero means `fn ` was not found
    if current_line == 0
        echo "Cannot toggle async: no `fn` found above." | return
    endif

    var line_content = getline(current_line)

    # If `async` is present, remove it from the current line
    if match(line_content, 'async\s') != -1
        execute $':{current_line}s/async //'
        winrestview(view) | return
    endif

    # If `pub` is present, add `async` after `pub`
    if match(line_content, 'pub\s') != -1
        execute $':{current_line}normal! ffiasync '
        winrestview(view) | return
    endif

    execute $':{current_line}normal! Iasync '
    winrestview(view)

enddef
autocmd FileType rust command! -nargs=0 ToggleAsync call ToggleAsync()


# Toggle the variable in the current line
# ---------------------------------------
def ToggleVariable(): void
    var current_col = col('.')
    var current_line = line('.')
    var line_content = getline('.')

    var matching = match(line_content, '\<let\> \<mut\> _')

    if matching >= 0
        execute "normal! ^wwx"
        if current_col > (matching + 9)
            cursor(current_line, current_col - 1) | return
        endif

        cursor(current_line, current_col) | return
    endif

    matching = match(line_content, '\<let\> \<mut\> ')

    if matching >= 0
        execute "normal! ^wwi_"
        if current_col > (matching + 8)
            cursor(current_line, current_col + 1) | return
        endif

        cursor(current_line, current_col) | return
    endif

    matching = match(line_content, '\<let\> _')

    if matching >= 0
        execute "normal! ^wx"
        if current_col > (matching + 5)
            cursor(current_line, current_col - 1) | return
        endif

        cursor(current_line, current_col) | return
    endif

    matching = match(line_content, '\<let\>')

    if matching >= 0
        execute "normal! ^wi_"
        if current_col > (matching + 4)
            cursor(current_line, current_col + 1) | return
        endif

        cursor(current_line, current_col) | return
    endif

    echo "Can't comment variable: no pattern was found in current line."
enddef
autocmd FileType rust
    \ command! -nargs=0 ToggleVariable
    \ call ToggleVariable()


# Toggle mutability of the current line's variable
# ------------------------------------------------
def ToggleMut(): void
    var current_col = col('.')
    var current_line = line('.')
    var line_content = getline('.')

    var matching = match(line_content, 'let\smut\s')
    if matching != -1
        execute ":s/let mut/let/"

        if current_col >= (matching + 7)
            cursor(current_line, current_col - 4) | return
        endif

        cursor(current_line, current_col) | return
    endif

    matching = match(line_content, 'let\s')

    if matching != -1
        execute ":s/let/let mut/"

        if current_col > (matching + 4)
            cursor(current_line, current_col + 4) | return
        endif

        cursor(current_line, current_col) | return
    endif

    echo "Cannot toggle mut: no valid pattern found."
enddef
autocmd FileType rust
    \ command! -nargs=0 ToggleMut
    \ call ToggleMut()


# Toggle the return type of a function
# -------------------------------------
def ToggleFnReturnType(): void
    var view = winsaveview()
    var current_line = line(".")

    var keywords = 'fn\s'

    # Search upwards for `fn `
    while current_line >= 1
        var line_content = getline(current_line)
        if match(line_content, keywords) != -1
            break
        endif

        current_line -= 1
    endwhile

    # Reaching line zero means `fn ` was not found
    if current_line == 0
        echo "Cannot toggle fn return type: no `fn` found above." | return
    endif

    var line_content = getline(current_line)

    if match(line_content, 'fn \w\+(.*) {') != -1
        execute $':{current_line}normal! $F)la->  '
        startinsert | return
    endif

    if match(line_content, 'fn \w\+(.*) -> .* {') != -1
        execute $':{current_line}' .. 'normal! $F-dt{'
    endif

    winrestview(view)

enddef
autocmd FileType rust
    \ command! -nargs=0 ToggleFnReturnType
    \ call ToggleFnReturnType()


# Writes a given scaffold from current position
# ---------------------------------------------
export def Scaffold(name: string): void
    if name == "actix"
        var lines = [
            \ '',
            \ 'use actix_web::{App, HttpServer, web, middleware::Logger};',
            \ 'use env_logger::{init_from_env, Env};',
            \ 'use std::net::TcpListener;',
            \ '',
            \ '#[actix_web::main]',
            \ 'async fn main() -> std::io::Result<()> {',
            \ '    init_from_env(Env::default().default_filter_or("debug"));',
            \ ' ',
            \ '    let listener = TcpListener::bind("127.0.0.1:8080")?;',
            \ '    HttpServer::new(|| {',
            \ '        App::new()',
            \ '            .wrap(Logger::default())',
            \ '            .route("/", web::get().to(|| async { "Rick Sanchez" }))',
            \ '    })',
            \ '    .listen(listener)?',
            \ '    .run()',
            \ '    .await',
            \ '}',
            \ ''
        \ ]

        call append(line('.') - 1, lines)
        exec "normal! {jj"

    else
        echo $"{name} is an unknown scaffold"

    endif
enddef
autocmd FileType rust command! -nargs=1 Scaffold call Scaffold(<f-args>)


# Writes lines for trait implementations
#---------------------------------------
export def Write(method: string): string
    if method == "asref"
        var lines = [
            \ 'impl AsRef<T> for V {',
            \ 'fn as_ref(&self) -> &T {}',
            \ '}',
            \ ''
        ]
        return join(lines, "\n")
    endif

    if method == "from"
        var lines = [
            \ 'impl From<T> for V {',
            \ 'fn from(value: T) -> Self {}',
            \ '}',
            \ ''
        ]
        return join(lines, "\n")
    endif

    if method == "deref"
        var lines = [
            \ 'impl Deref for V {',
            \ 'type Target = T;',
            \ '',
            \ 'fn deref(&self) -> &Self::Target {}',
            \ '}',
            \ ''
        ]
        return join(lines, "\n")
    endif

    if method == "display"
        var lines = [
            \ 'impl fmt::Display for T {',
            \ "fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {",
            \ 'write!(f, "{}", self.x)',
            \ '}',
            \ '}',
            \ ''
        ]
        return join(lines, "\n")
    endif

    if method == "test"
        var lines = [
            \ '#[cfg(test)]',
            \ "mod tests {",
            \ "use super::*;",
            \ "",
            \ "#[test]",
            \ "fn () {",
            \ "}",
            \ "}",
            \ ''
        ]
        return join(lines, "\n")
    endif

    return ""
enddef


# Makes single lines public
# --------------------------
def AddSingularPublic()
    var line_content = getline('.')
    if match(line_content, 'pub\s\|pub(crate)\s') != -1
        execute "normal! ^dW`s4\<left>"
    else
        execute "normal! Ipub \<esc>`s4\<right>"
    endif

enddef
autocmd FileType rust
    \ command! -nargs=0 AddSingularPublic
    \ call AddSingularPublic()


# Move the cursor to the function arguments
# ------------------------------------------------
def GoToFnArgs()
    var view = winsaveview()
    var current_line = line(".")
    var keywords = 'fn\s'

    # Search upwards for `fn `
    while current_line >= 1
        var line_content = getline(current_line)
        if match(line_content, keywords) != -1
            break
        endif

        current_line -= 1
    endwhile

    # Reaching line zero means `fn ` was not found
    if current_line == 0
        echo "Cannot move to fn arguments: no `fn` found above." | return
    endif

    cursor(current_line, 0) | exec "norma! f)"
enddef
autocmd FileType rust command! -nargs=0 GoToFnArgs call GoToFnArgs()


# Add packages to the project
# ------------------------------------------------
def CargoAdd(args: list<string>): void
    var currentFile = expand("%:p:h")
    var output = system($"sniffer Cargo.toml --origin {currentFile}")

    if (v:shell_error != 0)
        echo output | return
    endif

    var srcDir = fnamemodify(output, ":h")

    var command = $"cd {srcDir} && cargo add {join(args, " ")}"

    try
        system(command)
    catch
        echo "Failed to add packages."
    endtry
enddef
autocmd FileType rust
    \ command! -nargs=* CargoAdd
    \ call CargoAdd([<f-args>])


# Compile functions
# ------------------------------------------------
defcompile
