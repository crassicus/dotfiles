vim9script

g:nerdtree_is_open = false
g:fugitive_is_open = false


export def SearchUpwards(patterns: list<string>): number
    var original_position = getpos(".")
    var current_line_number = line(".")

    while current_line_number > 0
        var line_content = getline(current_line_number)

        for pattern in patterns
            if match(line_content, pattern) != -1
                cursor(current_line_number, 1)
                return 0
            endif
        endfor
        current_line_number -= 1
    endwhile

    return -1
enddef
command! -nargs=* SearchUpwards call SearchUpwards([<f-args>])


export def SearchDownwards(patterns: list<string>): number
    var original_position = getpos(".")
    var current_line_number = line(".")

    while current_line_number <= line("$")
        var line_content = getline(current_line_number)

        for pattern in patterns
            if match(line_content, pattern) != -1
                cursor(current_line_number, 1)
                return 0
            endif
        endfor
        current_line_number += 1
    endwhile

    return -1
enddef
command! -nargs=* SearchDownwards call SearchDownwards([<f-args>])


def ToggleNerdTree(): void
  if g:nerdtree_is_open == true

    exec "silent normal! :NERDTreeClose\<cr>"
    # Mutate global state
    g:nerdtree_is_open = false

  else
    # Set nerdtree width
    if &columns > 88
        g:NERDTreeWinSize = float2nr(&columns * 0.25)
    else
        g:NERDTreeWinSize = float2nr(&columns * 0.30)
    endif

    exec "silent normal! :NERDTreeFind\<cr>"

    # Mutate global state
    g:nerdtree_is_open = true
  endif
enddef
command! -nargs=0 ToggleNerdTree call ToggleNerdTree()


def ToggleFugitive(): void
  if g:fugitive_is_open == true
      execute "normal! :quit\<cr>"
      g:fugitive_is_open = false
  else
      execute "normal! :leftabove Git\<cr>"
      g:fugitive_is_open = true
  endif
enddef
command! -nargs=0 ToggleFugitive call ToggleFugitive()


def Spaces(): void
    var view = winsaveview()
    execute "normal! G"
    for _ in range(1, 11)
      append(line("."), "")
    endfor
    winrestview(view)
    execute "normal! zz"
enddef
command! -nargs=0 Spaces call Spaces()


def Gverdiff(parameter: string): void
  if parameter == ""
    execute "Gvdiffsplit HEAD~0:%"
    echo "Comparing with last commit." | return
  endif

  # Returns 0 when is not able to parse the given string into
  # an integer number
  var argument = str2nr(parameter)

  if argument < 0
    echo "Number of commits ago must be >= 1"
    echo "Call this function with no arguments for the last commit." | return
  endif

  if argument >= 1
    execute $"Gvdiffsplit HEAD~{argument}:%"
    echo $"Comparing with {argument} commits ago." | return
  endif

  execute $"Gvdiffsplit {parameter}"
  echo $"Comparing with branch {parameter}."
enddef
command! -nargs=? Gverdiff call Gverdiff(<q-args>)


def CommandFromRoot(args: list<string>)
    var args_string = join(args, " ")
    var command = $"cd {expand('$ROOT')} && {args_string}"
    echo trim(system(command))
enddef
command! -nargs=* CommandFromRoot call CommandFromRoot([<f-args>])


def CommentWord()
    var view = winsaveview()

    var current_word = expand("<cword>")
    var first_char = current_word[0]

    if first_char == '_'
        execute "normal! ebx"
    else
        execute "normal! ebi_"
    endif

    winrestview(view)
enddef
command! -nargs=0 CommentWord call CommentWord()


def ToggleWord()
    var view = winsaveview()
    var word = expand("<cword>")
    if word == "" | return | endif

    var first_letter: string
    var rest_of_word = word[1 :]

    if match(word, '^[A-Z].*') != -1
        first_letter = tolower(word[0])
    else
        first_letter = toupper(word[0])
    endif
    execute "normal! ciw" .. first_letter .. rest_of_word
    winrestview(view)
enddef
command! -nargs=0 ToggleWord call ToggleWord()


def BreakBrackets()
    var line_content = getline(line("."))

    if match(line_content, '{}') != -1
        execute "normal! 0f}i\<cr>\<cr>\<esc>k"
        feedkeys('S')
        return
    endif

    echo 'Pattern {} not found.'
enddef
command! -nargs=0 BreakBracketst call BreakBrackets()


export def CountMatches(line: string, expresion: string): number
  var count = 0
  var position = 0
  var result = -1

  while position >= 0
    result = match(line, expresion, position)
    if result >= 0
      count = count + 1
    else
      break
    endif

    position = result + 1
  endwhile

  return count
enddef


def YankCurrentPath(): void
    @+ = expand('%')
    if @+ == ""
        echom "❗ Current file seems to be nameless"
        return
    endif

    echo "🧭 " .. @+ .. " yanked"
enddef
command! -nargs=0 YankCurrentPath call YankCurrentPath()


def CloseNerdTreeOnQuit(): void
    if winnr('$') == 2 && exists("t:NERDTreeBufName") == 1
        execute "NERDTreeClose"
    endif
enddef

augroup CloseOnExit
    autocmd!
    autocmd QuitPre * call CloseNerdTreeOnQuit()
augroup END


def StartNerdTree(): void
    if &columns > 88 && g:nerdtree_is_open == false
        execute "silent normal! :ToggleNerdTree\<cr>"
        # Give cursor to main buffer
        call feedkeys("\<C-w>w", 'n')
    endif
enddef
autocmd VimEnter * ++once call StartNerdTree()


def GoToNerdTreeWindow(): void
    execute "silent normal! :NERDTreeRefreshRoot\<cr>"
    call feedkeys("\<C-w>w", "n")
enddef
command! -nargs=0 GoToNerdTreeWindow call GoToNerdTreeWindow()


def SwitchToBuffer(): void
    if bufname() !~ "NERD_tree_"
        call feedkeys("\<C-6>", "n")
    endif
enddef
command! -nargs=0 SwitchToBuffer call SwitchToBuffer()


def CloseSaving(): void
    if bufname() !~ "NERD_tree_"
        call feedkeys("ZZ", "n")
    endif
enddef
command! -nargs=0 CloseSaving call CloseSaving()


def CloseNotSaving(): void
    if bufname() !~ "NERD_tree_"
        call feedkeys("ZQ", "n")
    endif
enddef
command! -nargs=0 CloseNotSaving call CloseNotSaving()


export def Wrapper(input: string): string
    call feedkeys("\<BS>", "n")
    return input
enddef


defcompile
