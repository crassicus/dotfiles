vim9script

# Rust scripts

# Imports
import "../general/scripts.vim" as gen


# Toggle `pub` or `pub(crate)` on the nearest keyword above
# ---------------------------------------------------------
def TogglePub(): void
    var view = winsaveview()
    var current_line = line(".")

    var keywords = 'fn\s\|struct\|trait\|enum\|type'

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

    # If `pub` or `pub(crate )`is present, remove it from the current line
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
def ToggleAsync()
    var view = winsaveview()
    var current_line = line(".")

    var words = 'fn\s'

    # Search upwards for `fn `
    while current_line >= 1
        var line_content = getline(current_line)
        if match(line_content, words) != -1
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

    execute $':{current_line}normal! ffiasync '

    winrestview(view)
enddef
autocmd FileType rust command! -nargs=0 ToggleAsync call ToggleAsync()


# ------------------------------------------------
# Add a macro to a function or structure
# ------------------------------------------------
def RustAddMacro()
    var result = gen.SearchUpwards(["fn", "struct", "enum"])
    var line_content = getline('.')

    if result == 0
        execute "normal! O#[]"
        startinsert
    else
        echo "Failed to find pattern."
    endif
enddef
autocmd FileType rust command! -nargs=0 RustAddMacro call RustAddMacro()


# ------------------------------------------------
# Toggle underscore to suppress/restore unused warning
# ------------------------------------------------
def ToggleLeadingUnderscore(): void
    var view = winsaveview()
    var line_content = getline('.')

    # Case it's a mutable variable but not commented
    if match(line_content, '\s*let\smut\s[^_][a-z0-9_\:]\+\s.*=') != -1
        exec "normal! ^WWi_"
        winrestview(view)
        return
    endif

    # Case it's a mutable variable but commented
    if match(line_content, '\s*let\smut\s[a-z0-9_\:]\+\s.*=') != -1
        exec "normal! ^WWx"
        winrestview(view)
        return
    endif

    # Case it's just not commented
    if match(line_content, '\s*let\s[^_][a-z0-9_\:]\+\s.*=') != -1
        exec "normal! ^Wi_"
        winrestview(view)
        return
    endif

    # Case it's commented
    if match(line_content, '\s*let\s[a-z0-9_\:]\+\s.*=') != -1
        exec "normal! ^Wx"
        winrestview(view)
        return
    endif

    echo "-> Failed to find pattern..."

enddef
autocmd FileType rust command! -nargs=0 ToggleLeadingUnderscore call ToggleLeadingUnderscore()


# ------------------------------------------------
# Toggle variable mutability
# ------------------------------------------------
def RustToggleMutability()
    var line_content = getline('.')

    if match(line_content, 'let\smut') != -1
        execute "normal! ^wdiwx\<esc>`s4\<left>"

    elseif match(line_content, 'let') != -1
        execute "normal! ^wimut\<space>\<esc>`s4\<right>"

    else
        echo "Failed to find pattern."
    endif

enddef
autocmd FileType rust command! -nargs=0 RustToggleMutability call RustToggleMutability()


# ------------------------------------------------
# Toggle the return type of a function
# ------------------------------------------------
def RustToggleFunctionReturnType()
    var view = winsaveview()
    var result = gen.SearchUpwards(['fn\s.*'])
    var line_content = getline('.')

    if result == -1
        echo "Failed to find function pattern."
        winrestview(view)
        return
    endif

    if match(line_content, '{') == -1
        exe "normal! /^)\<cr>"
        line_content = getline('.')
    endif


    if match(line_content, '{') != -1 && match(line_content, 'fn(.*)\s\->') != -1

        var arrow_matches = gen.CountMatches(line_content, '\->')
        var fn_matches = gen.CountMatches(line_content, 'fn(.*)\s\->')

        if arrow_matches == fn_matches
            # There's not return signature
            exe "normal! $F)a\<space>->\<space>\<right>"
            startinsert
        else
            # There's return signature
            exe "normal! $F-dt{"
            winrestview(view)
        endif

        return
    endif

    if match(line_content, '{') != -1 && match(line_content, 'fn(.*)\s\->') == -1

        if match(line_content, '\->') != -1
            exe "normal! ^f-dt{"
            winrestview(view)
        else
            exe "normal! ^f{F)a\<space>->\<space>\<right>"
            startinsert
        endif
        return
    endif


    if match(line_content, '\->') != -1
        if match(line_content, 'where') != -1
            exe "normal! ^f-d/where\<cr>"
            winrestview(view)
        else
            exe "normal! ^f-d$"
            winrestview(view)
        endif
    else
        exe "normal! ^a\<space>->\<space>\<right>"
        startinsert
    endif

enddef
autocmd FileType rust command! -nargs=0 RustToggleFunctionReturnType call RustToggleFunctionReturnType()


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


# ------------------------------------------------
# Makes single lines public
# ------------------------------------------------
def AddSingularPublic()
    var line_content = getline('.')
    if match(line_content, 'pub\s\|pub(crate)\s') != -1
        execute "normal! ^dW`s4\<left>"
    else
        execute "normal! Ipub \<esc>`s4\<right>"
    endif

enddef
autocmd FileType rust command! -nargs=0 AddSingularPublic call AddSingularPublic()


# ------------------------------------------------
# Jumps the cursor to args part of a function
# ------------------------------------------------
def TakeMeToArgs()
    var result = gen.SearchUpwards(['fn\s'])

    if result == 0
        execute "normal! f)"
        echo "Taken to function arguments..."
    else
        echo "Failed to find pattern."
    endif
enddef
autocmd FileType rust command! -nargs=0 TakeMeToArgs call TakeMeToArgs()


# ------------------------------------------------
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


autocmd FileType rust command! -nargs=* CargoAdd call CargoAdd([<f-args>])


# ------------------------------------------------
# Compile functions
# ------------------------------------------------
defcompile
