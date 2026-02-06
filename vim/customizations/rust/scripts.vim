vim9script

# ==== Rust Scripts ====

import "../general/scripts.vim" as gen

# ------------------------------------------------
# Toggle visibility state for the expression
# ------------------------------------------------
def RustAddPublic()
    var view = winsaveview()

    var result = gen.SearchUpwards(['fn\s', 'struct', 'trait', 'enum', 'type'])
    var line_content = getline(".")

    # If `pub` was found in current line
    if match(line_content, 'pub\s\|pub(crate)\s') != -1
        execute "normal! ^dW"
        winrestview(view)
        return
    endif

    if result == 0
        execute "normal! Ipub "
    else
        echo "Failed to find pattern."
    endif

    winrestview(view)
enddef
autocmd FileType rust command! -nargs=0 RustAddPublic call RustAddPublic()


# ------------------------------------------------
# Toggle async state for the function
# ------------------------------------------------
def RustAddAsync()
    var view = winsaveview()
    var result = gen.SearchUpwards(["fn"])
    var line_content = getline(".")

    # if Async was found in current line
    if match(line_content, 'async\s') != -1
        execute "normal! :s/async\<space>//\<cr>"
        winrestview(view)
        return
    endif

    if result == 0
        execute "normal! ^fn\<left>iasync \<esc>"
    else
        echo "Failed to find pattern."
    endif

    winrestview(view)
enddef
autocmd FileType rust command! -nargs=0 RustAddAsync call RustAddAsync()


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


# ------------------------------------------------
# Scaffold for implementing the given trait
# ------------------------------------------------
def Implement(trait: string)
    if trait == "from"
        var lines = [
            \ '',
            \ 'impl From<T> for V {',
            \ 'fn from(value: T) -> Self {}',
            \ '}',
            \ ''
        \ ]

        execute "normal! i" .. join(lines, "\n")
        execute "normal! kkkfT"

    elseif trait == "asref"
        var lines = [
            \ '',
            \ 'impl AsRef<T> for V {',
            \ 'fn as_ref(&self) -> &T {}',
            \ '}',
            \ ''
        \ ]

        execute "normal! i" .. join(lines, "\n")
        execute "normal! {jfT"

    elseif trait == "deref"
        var lines = [
            \ '',
            \ 'impl Deref for V {',
            \ 'type Target = T;',
            \ '',
            \ 'fn deref(&self) -> &Self::Target {}',
            \ '}',
            \ ''
        \ ]

        execute "normal! i" .. join(lines, "\n")
        execute "normal! {{jfVx"
        startinsert

    elseif trait == "display"
        var lines = [
            \ '',
            \ 'impl fmt::Display for T {',
            \ "fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {",
            \ 'write!(f, "{}", self.x)',
            \ '}',
            \ '}',
            \ ''
        \ ]

        execute "normal! i" .. join(lines, "\n")
        execute "normal! {jfTx"
        startinsert

    else
        echo "Unknown implementation."
    endif

enddef
autocmd FileType rust command! -nargs=1 Implement call Implement(<f-args>)


export def Scaffold(name: string): void
    if name == "actix"
        var lines = [
            \ '',
            \ 'use actix_web::{App, HttpServer, web, middleware::Logger};',
            \ 'use env_logger::{init_from_env, Env};',
            \ '',
            \ '#[tokio::main]',
            \ 'async fn main() -> std::io::Result<()> {',
            \ '',
            \ '    init_from_env(Env::default().default_filter_or("debug"));',
            \ '    HttpServer::new(|| {',
            \ '        App::new()',
            \ '            .wrap(Logger::default())',
            \ '            .route("/", web::get().to(|| async { "Rick Sanchez" }))',
            \ '    })',
            \ '    .bind(("127.0.0.1", 8080))?',
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
# Moves cursor to `use` statements
# ------------------------------------------------
def MovesToUseStatements()
    execute "norm! gg"
    var result = gen.SearchDownwards(['^use\s'])

    if result != 0
        execute "norm! }o" | startinsert | return
    endif

    cursor(result, 1)
    execute("norm! }k$h")
enddef
autocmd FileType rust command! -nargs=0 MovesToUseStatements call MovesToUseStatements()


# ------------------------------------------------
# Compile functions
# ------------------------------------------------
defcompile
