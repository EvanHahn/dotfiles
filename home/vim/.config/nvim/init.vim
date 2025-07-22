" ----------------------------------------------------------------------------
"
" Start by setting options that affect reading of Vim startup files.
"
" ----------------------------------------------------------------------------

" Deviate from Vi compatibility. This does nothing in Neovim, which is "always
" 'nocompatible'". In vanilla Vim, this sets a bunch of options, and its docs
" recommend putting this "at the very start" of your vimrc.
"
" Because this affects other options, I don't want it to run if I re-source my
" init.vim, which is why I have that check.
if has('vim_starting')
	set nocompatible
endif

" My config files use UTF-8. This only affects vanilla Vim because Neovim
" always uses UTF-8. It's probably fine to set this later, but I set it at the
" top just in case.
set encoding=utf-8

" ----------------------------------------------------------------------------
"
" All options, in alphabetical order.
"
" ----------------------------------------------------------------------------
"
" `aleph` doesn't exist in Neovim. It concerns Hebrew text, which I don't use,
" so I don't bother to set this option. I leave it as its default. See `hkmap`
" and `hkmapp`.

" CTRL-_ in Insert mode should not toggle Reverse Insert mode. See `revins`.
set noallowrevins

" Д should be the same width as ASCII characters. Must be `single` if
" `listchars` or `fillchars` contains a character that could be double-width.
set ambiwidth=single

" I rarely (never?) edit Arabic text, so I don't need this option. If I *do*
" need it, I could enable it for a buffer. See `rightleft`.
set noarabic

" I don't know Arabic, so let's keep it simple and show "each character's true
" stand-alone form". See `arabic`.
set noarabicshape

" Don't automatically change directories when I open a buffer. Also, "some
" plugins may not work" if I enable this.
set noautochdir

" Auto-indent copies indentation from the current line when starting a new
" one and tweaks formatting. See `cindent`, `smartindent`, and `indentexpr`.
set autoindent

" Update the file if it's changed outside of Vim.
set autoread

" Similar to `autochdir`, but for vanilla Vim's built-in terminal. I don't
" want to change Vim's directory when the terminal directory changes.
if exists('+autoshelldir')
	set noautoshelldir
endif

" I only want files to save when I run `:w` or equivalent. `autowrite` and
" `autowriteall` aren't what I want.
set noautowrite
set noautowriteall

" `background` should use my system theme, which is set by my primitive
" `theme` command. If not found, it should use a dark theme. In Neovim, I
" watch this file and change the background automatically.
set background=dark
if filereadable(expand('$HOME/.cache/evanhahn-vim-theme'))
	let theme = trim(readfile(expand('$HOME/.cache/evanhahn-vim-theme'))[0])
	if theme ==# 'light' || theme ==# 'dark'
		execute 'set background=' . theme
	endif
endif

" Change how <BS>, <Del>, CTRL-W, and CTRL-U work in Insert mode.
" - `indent`: backspace over autoindents (see `autoindent`)
" - `eol`: backspace over line breaks
" - `nostop`: backspace over start of insert
set backspace=indent,eol,nostop

" When writing to an existing file, I want to make a backup in case of
" catastrophe; that's why I enable `writebackup`. However, I don't want this
" backup to stick around after the write is finished, because (1) I don't want
" to clutter up my disk (2) I don't want to accidentally save something
" sensitive somewhere. Therefore, I disable the `backup` option.
"
" I think Vim's docs for backup (`:help backup`) are weak, and [this Stack
" Exchange answer][0] explains things much more clearly.
"
" [0]: https://vi.stackexchange.com/a/16846
set nobackup

" When writing to an existing file, a backup is created if `backup` or
" `writebackup` are enabled. Then one of two things happens:
"
" 1. The original is copied, then overwritten
" 2. The original is renamed and a new file is written in its place
"
" Most of the time, the difference here doesn't matter. But reading
" `:help 'backupcopy'` reveals many subtleties:
"
" - Renaming is faster than copying.
" - File attributes, like the owner and group, may or may not be changed.
" - Symlinks and hardlinks can have subtle issues.
" - Renaming could cause issues with tools that are looking at the file
"   descriptor, like inotify. After all, the updated file will have a new file
"   descriptor.
"
" Most of the time, these subtleties are irrelevant, and I have not noticed
" any issues, so I choose the "auto" option.
set backupcopy=auto

" In Neovim, store backup files in the state folder. In vanilla Vim, use a
" backup folder in `~/.vim`.
if has('nvim')
	let &backupdir = stdpath('state') . '/backup//'
else
	silent! execute '!mkdir -p ' . expand('$HOME/.vim/backup/')
	let &backupdir = expand('$HOME/.vim/backup//')
endif

" Use a very explicit backup filename.
set backupext=.vim-backup

" Vim's default `backupskip` is good enough for me, and a little tricky to set
" myself, so I don't set it explicitly.

" In the rare case that I'm using a Vim distribution that has the
" `balloon_eval` feature enabled, disable it because I never use it. Neovim
" removes this feature and I think it's only in GUI versions of vanilla Vim.
" Because this is disabled and I don't know much about this feature, I ignore
" related options `balloondelay` and `balloonexpr`.
if has('balloon_eval')
	set noballooneval
endif
if has('balloon_eval_term')
	set noballoonevalterm
endif

" Ring the Vim bell all the time, except for when I hit <Esc> in Normal mode.
" See `visualbell`.
set belloff=esc

" The `binary` option is buffer-local, so I don't set it globally.

" Don't append the byte order mark.
set nobomb

" When `linebreak` is on, break at these characters. This only affects the way
" the file is displayed, not its contents. `^I` is a tab character.
set breakat=\ ^I!@*_-+;:,./?

" "Every wrapped line will continue visually indented (same amount of space as
" the beginning of that line), thus preserving horizontal blocks of text."
"
" And for some options:
" - Don't go narrower than 40 characters.
" - Don't shift the wrapped lines at all.
" - Show the value of `showbreak` at the beginning of the shift, if it
"   exists.
" - Add indent for lines that match a bulleted or numbered list. See
"   `formatlistpat`.
if exists('+breakindent')
	set breakindent
	set breakindentopt=min:40,shift:0,sbr,list:-1
endif

" In GUI Vim, where should the native file browser go? This option is "not yet
" implemented" by Neovim, but is part of vanilla Vim, I think.
if has('gui')
	try
		set browsedir=current
	catch /^Vim\%((\a\+)\)\=:E519:/
	endtry
endif

" See `hidden`.
set bufhidden=

" `buflisted` and `buftype` are unspecified because they are buffer-local.

" When changing the case of letters, (1) use Vim's internal case modifier, not
" the system ones (2) always treat ASCII characters like English, which seems
" to only affect Turkish, according to the Vim docs.
set casemap=internal,keepascii

" `:cd` and friends should work like in Unix and go `$HOME`.
set cdhome

" `:cd` and friends should search the current directory.
set cdpath=,,

" Press this key in Command mode to open the command line window. (You can
" also open this with `q:`).
set cedit=<C-F>

" `channel` is read-only and buffer-local, so we don't set it.

" `charconvert` doesn't seem used very often. It is "not used when the
" internal iconv() function is supported and is able to do the conversion",
" and "conversion between 'latin1', 'unicode', 'ucs-2', 'ucs-4' and 'utf-8' is
" done internally".
"
" I've never run into this, so I just set it to the empty string, the default.
set charconvert=

" Indentation varies by language. Normally, this is controlled by
" filetype-specific `indentexpr`, which overrides `cindent` and `smartindent`.
"
" But as a fallback, I don't want to assume C-style program indenting, which
" both `smartindent` and `cindent` do.
"
" `cindent` also has some ancillary options (`cinkeys`, `cinscopedecls`, and
" `cinwords`) which I leave unset. I like the default behavior of `cinoptions`
" so I leave that explicitly empty.
set nocindent
set cinoptions=

" Just yank to the unnamed register by default. In other words, don't copy to
" the system clipboard by default. (Neovim and vanilla Vim have fairly
" different clipboard behaviors, at least in theory, but that's not relevant
" to this option.)
set clipboard=

" How tall should the command line be? I'd like this to be as small as
" possible. Neovim experimentally supports a `cmdheight` of 0, which seems a
" little buggy based on GitHub issues, so I go with 1. (Vanilla Vim has no
" such support, even experimental.)
set cmdheight=1

" How tall should the command line window be? The default seems reasonable to
" me. See also: `cedit`.
set cmdwinheight=7

" Show a column at `textwidth` if it's nonzero, otherwise show nothing.
if has('syntax')
	set colorcolumn=+0
endif

" In terminal Vim, `columns` is set by the terminal, so I shouldn't set it. In
" GUI Vim, which I don't use, I'll trust whatever default they give. See
" `lines`.

" Different `ftplugin`s set different values for `comments`. For example,
" Ruby's is `b:#`. Vim deals with this in all sorts of ways, including the
" `gc` text object and formatting with `gq`.
"
" Most `ftplugin`s set reasonable values for this, and the default is kinda
" wild, so let's disable it.
set comments=

" See `comments`.
set commentstring=

" When using CTRL-N completion, look at the current buffer (`.`), buffers in
" other windows (`w`), other loaded buffers (`b`), and buffer names `f`.
"
" `f` means something different in Neovim versus [vanilla Vim][0], so only
" enable it in Neovim.
"
" [0]: https://github.com/vim/vim/commit/cbe53191d01926c045a39198b3a9517e3c5077d2
set complete=.,w,b
if has('neovim')
	set complete+=f
endif

" `completefunc`, which controls Insert mode completion (CTRL-X CTRL-U), is
" language-specific, so I don't set it here. However, I don't typically set
" this, and rely on `omnifunc` or Neovim's completion system.

" When showing a completion option, you must show the "abbr" (which, from my
" experience, is typically the completion candidate), the "kind" (which is
" something like "Method" or "Field"), and the "menu" (which is extra stuff,
" which varies). I like that order.
if exists('+completeitemalign')
	set completeitemalign=abbr,menu,kind
endif

" Autocomplete should be fuzzy and show a menu.
"
" I don't add the `popup` flag to `completeopt`, nor do I set the
" `completepopup` option. Neovim hasn't implemented this feature, and I could
" not for the life of me figure out how to activate it in vanilla Vim.
set completeopt=menu,longest
if has('patch-9.1.0463')
	set completeopt+=fuzzy
endif

" Use the behavior of `shellslash` without any overrides.
set completeslash=

" Vim's conceal feature lets you visually transform syntax, even if the file
" on disk is unaffected. For example, [this blog post shows heavy conceal
" usage][0], and gives this before/after example:
"
" ```
" identity = lambda x: x
" identity = λ x: x
" ```
"
" Here, they've transformed `lambda` into `λ`.
"
" This is neat, but (1) I prefer to see exactly the thing (2) concealing
" could affect copy-paste (3) concealing is buggy/weird in my experience, and
" [it seems I'm not alone][1]. For all those reasons, I disable concealing as
" much as I can. See also: `after/ftplugin/help.vim`, where I disable it
" there.
"
" [0]: https://alok.github.io/2018/04/26/using-vim-s-conceal-to-make-languages-more-tolerable/
" [1]: https://github.com/vim/vim/issues/260
set concealcursor=
set conceallevel=0

" Don't let me quit without saving.
set confirm

" When auto-indenting a new line, copy the existing indent. Like
" `preserveindent`, but for new lines.
set copyindent

" `cpoptions` dictates Vi-compatible behavior. I don't care about Vi
" compatibility directly, but I do care about certain behaviors. The docs
" recommend adding and removing them with `+=` and `-=` in case there are
" flags I don't know about in this file.
function! s:SetCpoptionsFlag(flag, enabled) abort
	if a:enabled
		try
			execute 'set cpoptions+=' . a:flag
		catch /^Vim\%((\a\+)\)\=:E539:/
		endtry
	else
		execute 'set cpoptions-=' . a:flag
	endif
endfunction
" `:read`ing another file should not set the alternate file name. See `:help
" alternate-file`.
call s:SetCpoptionsFlag('a', v:false)
" :write` with a file name argument should set the alternate file name for the
" current window. See `:help alternate-file`.
call s:SetCpoptionsFlag('A', v:true)
" `\|` in a `:map` command should not be special.
call s:SetCpoptionsFlag('b', v:false)
" Backslashes should have no special meaning in mappings.
call s:SetCpoptionsFlag('B', v:true)
" "'abababababab' only gets three matches when repeating '/abab', without `c`
" there are five matches."
call s:SetCpoptionsFlag('c', v:true)
" When `:source`ing a file, I want to treat backslashes as line continuations.
call s:SetCpoptionsFlag('C', v:false)
" I don't use tags so I don't care about this option.
call s:SetCpoptionsFlag('d', v:false)
" I want to be able to enter a digraph in Normal mode after a character
" argument like `r`. For example, entering `r<C-K>12` should replace the
" current character with `½`.
call s:SetCpoptionsFlag('D', v:false)
" When executing a register that isn't linewise, I don't want to execute it
" immediately.
call s:SetCpoptionsFlag('e', v:false)
" No-op when operating on an empty region. For example, `y0` fails on the
" first column. (The docs say "it is an error" but I don't actually see an
" error when I test this, only a no-op.)
call s:SetCpoptionsFlag('E', v:true)
" `:read` with a file name argument shouldn't change the current buffer's file
" name if the current buffer lacks one.
call s:SetCpoptionsFlag('f', v:false)
" `:write` should fill in the buffer's file name if one is missing.
call s:SetCpoptionsFlag('F', v:true)
" Vanilla Vim's `g` flag moves your cursor to the first line when running
" `:edit` with no arguments. I don't want this.
call s:SetCpoptionsFlag('g', v:false)
" Vanilla Vim's `H` flag affects the way `I` works if you're on a completely
" blank line. I don't want to enable it.
call s:SetCpoptionsFlag('H', v:false)
" If you open a buffer and interrupt it while it's reading, mark it modified
" (like `:set modified`). I couldn't reproduce this and the source code wasn't
" particularly illuminating, but it seems like a reasonable thing to enable.
call s:SetCpoptionsFlag('i', v:true)
" Leaving this unset will delete auto-indents if you move away from them. I
" don't want trailing whitespace.
call s:SetCpoptionsFlag('I', v:false)
" In Vanilla Vim only, treat `.`, `!`, and `?` the same when joining lines.
call s:SetCpoptionsFlag('j', v:false)
" Sentences don't have to be followed by two spaces.
call s:SetCpoptionsFlag('J', v:false)
" Allow raw key codes in mappings. Exclusive to vanilla Vim.
call s:SetCpoptionsFlag('k', v:false)
" I don't completely understand the `k` flag, but it's exclusive to vanilla
" Vim (removed from Neovim in `3baba1e7bc6698e6bc9f1d37fce88b30d6274bc9`) and
" I don't think I want it enabled.
call s:SetCpoptionsFlag('k', v:false)
" I want to wait for key codes to complete when halfway through a mapping. In
" Neovim, this option seems to do nothing (based on `git grep CPO_KOFFSET`),
" other than avoid an error when someone sets `cpoptions=K`. It does look like
" it does something in Vim though.
call s:SetCpoptionsFlag('K', v:false)
" Backslashes in `[]` are not taken literally. The docs at `:help cpo-l` offer
" a useful example of why I don't include this.
call s:SetCpoptionsFlag('l', v:false)
" Tabs shouldn't count as two characters when `list` is enabled.
call s:SetCpoptionsFlag('L', v:false)
" I disable `showmatch`, but if I enable it, I want to abort if a character is
" typed.
call s:SetCpoptionsFlag('m', v:false)
" This is overwritten by the `matchit` plugin, which is enabled in (my setup
" of) Neovim, so this option really only affects vanilla Vim. There, I want
" backslashes to be ignored when matching characters with `%`. See `:help
" cpo-M` for an example, and the `matchpairs` option.
call s:SetCpoptionsFlag('M', v:true)
" The `number` and `relativenumber` columns shouldn't count toward text
" wrapping. I couldn't reproduce this with soft wrapping (the `wrap` option)
" but I did see a reduction in `textwidth` when enabling this.
call s:SetCpoptionsFlag('n', v:false)
" When you do a search, you can specify an offset (see `:help search-offset`).
" Where `/foo/` will put your cursor right on top of the next occurrence of
" `foo`, `/foo/+5` will put your cursor five lines down from the next
" occurrence. (I'm not sure when this would be useful but I'm sure there's a
" good time.) If I ever do this, I want to press `n` and have it remember that
" line offset. Therefore, I do not set the `o` flag.
call s:SetCpoptionsFlag('o', v:false)
" In the following sequence, I want an error: (1) I run `vim file.txt` when
" `file.txt` doesn't exist (2) `file.txt` is created elsewhere (3) I try to
" write that file.
call s:SetCpoptionsFlag('O', v:false)
" Don't use vanilla Vim's Vi-compatible Lisp indenting. Not in Neovim.
call s:SetCpoptionsFlag('p', v:false)
" Like `F`. `:write` can append to a file, and if the written buffer lacks a
" name, sets the file name. Requires the `F` flag to be on.
call s:SetCpoptionsFlag('P', v:true)
" When you join more than two lines, where should the cursor go? With this
" flag enabled, it goes between the first and second lines. Disabled, it goes
" between the penultimate and last lines. I tried both and *slightly* prefer
" when this is on.
call s:SetCpoptionsFlag('q', v:true)
" If you perform an action with a search motion (like `d/foo`) and then change
" the search (like `/bar`), then use `.` to repeat the action, it should use
" the original search, not the new one. Thanks to [this StackExchange
" answer][0].
" [0]: https://vi.stackexchange.com/a/46864/56767
call s:SetCpoptionsFlag('r', v:false)
" Don't remove marks from filtered lines. See `:help filter`.
call s:SetCpoptionsFlag('R', v:false)
" I think I want buffer-local options to be copied from the active buffer when
" entering the buffer for the first time, not when the buffer is created. I
" think these are *usually* done at about the same time, but there might be
" some case where a buffer is created that isn't entered. I couldn't easily
" see the difference when toggling this flag, but it *is* the default, so I'll
" set it and probably be fine.
call s:SetCpoptionsFlag('s', v:true)
" I don't want to set buffer options whenever I enter a buffer. See the `s`
" option above.
call s:SetCpoptionsFlag('S', v:false)
" I don't use tags so I don't care about this option.
call s:SetCpoptionsFlag('t', v:false)
" I want `uu` to undo two changes, not be a no-op. See `:help undo-two-ways`.
call s:SetCpoptionsFlag('u', v:false)
" I don't want backspaced characters to remain visible on the screen.
call s:SetCpoptionsFlag('v', v:false)
" Vanilla Vim exclusive: `cw` on a blank character should eat all whitespace,
" not a single character.
call s:SetCpoptionsFlag('w', v:false)
" You can overwrite a readonly file with `:w!`, but this can change the user
" and/or group of the file. I don't want this, so I enable the `W` flag. See
" the docs for `:write!`.
call s:SetCpoptionsFlag('W', v:false)
" `<Esc>` on the command line should abandon the command, not execute it.
call s:SetCpoptionsFlag('x', v:false)
" A count with `R` should clobber `count * changed_characters` characters, not
" `count` characters. For example, imagine your cursor is at the beginning of
" `abcdefg` and you type `3Rxx`. When the `X` `cpoptions` flag is disabled,
" the result is `xxxxxxg`. When ebaled, the result is `xxxxxxcdefg`.
call s:SetCpoptionsFlag('X', v:false)
" You shouldn't be able to redo a yank with `.`. Even the documentation says
" "think twice if you really want to use this".
call s:SetCpoptionsFlag('y', v:false)
" Vanilla Vim's documentation for its exclusive `z` flag isn't super clear,
" but I don't think I want to enable it. See `:help cpo-z`.
call s:SetCpoptionsFlag('z', v:false)
" This should have no effect because I enable the `W` flag above, but if I
" ever disable it, I guess I want the `readonly` flag to disappear when using
" `:write!`.
call s:SetCpoptionsFlag('Z', v:false)
" When redoing a filter, reuse the last filter command, not the last external
" command (which might be different).
call s:SetCpoptionsFlag('!', v:false)
" When changing a line, show the changes. Don't do a weird sorta-overwrite.
call s:SetCpoptionsFlag('$', v:false)
" Use more advanced behavior for the `%` command. In Neovim, this is
" completely irrelevant because of the `matchit` plugin.
call s:SetCpoptionsFlag('%', v:false)
" A vertical movement shouldn't fail when going too high or too low. For
" example, `99999999k` should take you to the first line, not fail. This
" flag is exclusive to vanilla Vim.
call s:SetCpoptionsFlag('-', v:false)
" `:write` shouldn't necessarily reset the `modified` flag for a buffer. These
" are usually in sync, but if you modify file A and then `:write B` without
" saving A first, `modified` should still be set.
call s:SetCpoptionsFlag('+', v:false)
" Vanilla Vim only: `:*` should be normal.
call s:SetCpoptionsFlag('*', v:false)
" Recognize `<` and `>` in key mappings, so that things like `:map X <Tab>`
" works. Exclusive to vanilla Vim.
call s:SetCpoptionsFlag('<', v:false)
" Don't put a line break before text appended to a register.
call s:SetCpoptionsFlag('>', v:false)
" `,` and `;` should keep going after something is found, not halt.
call s:SetCpoptionsFlag(';', v:false)
" Omit whitespace when using `cw` on a word.
call s:SetCpoptionsFlag('_', v:true)
" Disable all of vanilla Vim's POSIX flags.
call s:SetCpoptionsFlag('#', v:false)
call s:SetCpoptionsFlag('&', v:false)
call s:SetCpoptionsFlag('\', v:false)
call s:SetCpoptionsFlag('/', v:false)
call s:SetCpoptionsFlag('{', v:false)
call s:SetCpoptionsFlag('.', v:false)
call s:SetCpoptionsFlag('|', v:false)

" Vanilla Vim (not not Neovim) has encryption support, which is a bit wonky.
" The `cryptmethod` option configures the encryption method, and it's
" sometimes auto-detected. I'll let Vim decide what to do here. See also:
" `key`.

" "Cscope support was removed [from Neovim] in favor of plugin-based
" solutions", but it's still in vanilla Vim. Like ctags, I don't use it, so I
" don't set any of its options:
"
" - `cscopepathcomp`
" - `cscopeprg`
" - `cscopequickfix`
" - `cscoperelative`
" - `cscopetag`
" - `cscopetagorder`
" - `cscopeverbose`

" Don't bind cursors. This gets overridden in diff mode (`nvim -d`). See
" `scrollbind`.
set nocursorbind

" Show a highlight at the current line, but not the current column. The
" cursorline should highlight the full line (which could be multiple screen
" lines) and the line number, if `number` or `relativenumber` are on.
if has('syntax')
	set nocursorcolumn
	set cursorline
	set cursorlineopt=both
endif

" Disable any debug messages. (This is the default.)
set debug=

" Different `ftplugin`s set different values for `define`. For example, C's is
" `^\s*#\s*define`. I admit I'm not super clear on how this used, but a
" default empty value seems reasonable.
set define=

" Hit backspace to delete combining characters piece by piece, not all at
" once. Irrelevant for ASCII, but some Unicode glyphs may be made up of
" combining characters, such as the farmer emoji. (The naming of this seems
" flipped to me. Shouldn't `delcombine` combine characters and `nodelcombine`
" separate them?)
set delcombine

" Look up words for keyword completion (CTRL-X CTRL-K in Insert mode).
"
" Keyword completion will break if the file in `/usr/` doesn't exist, which is
" fine with me. The `spell` entry uses the spell check dictionary, but only
" works if `spell` is enabled—better than nothing.
"
" The docs recommend using `set dictionary+=` instead of what I do here, in
" case they change the default. I'm ignoring that advice because the default
" is empty.
set dictionary=/usr/share/dict/words,spell

" `diffexpr` dictates how diff files should be computed. If you leave it
" empty, Vim can use its internal diff library in `diffopt`, which is what I
" want.
if has('diff')
	set diffexpr=
endif

" Settings for diff mode (vimdiff).
"
" - `algorithm:patience` uses a different diff algorithm which, anecdotally,
"   gives more intuitive results than the default.
" - `closeoff` effectively leaves diff mode when you quit one of the files.
" - `context:2` gives two lines of context around changes.
" - `filler` keeps text aligned when files are side-by-side.
" - `internal` uses the internal diff library, which enables some of the other
"   features listed here, such as `algorithm`.
" - `iwhiteall` ignores all white space changes.
" - `vertical` opens diffs in vertical splits by default.
"
" See <https://vimways.org/2018/the-power-of-diff/> for examples of the
" `algorithm` and `indent-heuristic` settings.
"
" `internal`, and therefore `indent-heuristic`, are unsupported on some
" versions of Vim. In addition to requiring [patch 8.1.0362][0], macOS's stock
" Vim annoyingly lacks support despite it being partially documented. (See
" [this blog post][0] and [this comment][1] for details.) Rather than try to
" detect these cases, I just try to set them and silently ignore failures.
"
" [0]: https://github.com/vim/vim/commit/e828b7621cf9065a3582be0c4dd1e0e846e335bf
" [1]: https://www.micahsmith.com/blog/2019/11/fixing-vim-invalid-argument-diffopt-iwhite/
" [2]: https://github.com/thoughtbot/dotfiles/issues/655#issuecomment-605019271
if has('diff')
	set diffopt=closeoff,context:2,filler,iwhiteall,vertical
	try
		set diffopt+=internal,algorithm:patience
	catch /^Vim\%((\a\+)\)\=:E474:/
	endtry
endif

" "Digraphs are used to enter characters that normally cannot be entered by
" an ordinary keyboard." For example, you can enter "½" in Insert mode with
" CTRL-K 1 2. There's a big list in `:digraphs`, and `:help diagraphs` has
" much more to say.
"
" In addition to the CTRL-K method above, if the `digraph` option is set, you
" can do 1 <BS> 2. I'm likely to do this by accident and *only* by accident,
" so I disable it.
if has('digraphs')
	set nodigraph
endif

" In Neovim, store swap files in the state folder. In vanilla Vim, use a
" folder in `~/.vim`. See `swapfile`.
if has('nvim')
	let &directory = stdpath('state') . '/swap//'
else
	silent! execute '!mkdir -p ' . expand('$HOME/.vim/swap/')
	let &directory = expand('$HOME/.vim/swap//')
endif

" `display` sets two pretty unrelated text display options:
"
" - `lastline` affects the last screen line of a window. If it can't be fully
"   displayed, `@@@` replaces the end of the line. I change this to `...` with
"   `fillchars`. In my opinion, the behavior here is subtle, but I suppose
"   `lastline` is my slight preference.
"
" - `uhex` shows unprintable characters in a preferable format, like `<xx>`.
"
" (Not totally sure why these options are grouped together, but I'm not Bram
" Moolenar.)
set display=lastline,uhex

" When windows are automatically resized, only change the width. See
" `equalalways`.
set eadirection=hor

" Don't toggle `g` and `c` flags when using `:substitute`. No-op in Neovim,
" where the option doesn't exist.
set noedcompatible

" Consider Unicode emoji to be full width.
set emoji

" See `encoding` set at the top of this file.

" `endoffile` and `endofline` are "normally detected automatically when
" reading the file", so I don't set it here. See `:help eol-and-eof`.

" When splitting or closing a window, adjust their size. See `eadirection`.
set equalalways

" By default, use internal formatting functions for `=`. This might get
" overwritten by a language-specific value.
set equalprg=

" Ring the bell for error messages. See `belloff`.
set errorbells

" Starting Vim with the `-q` option (like `vim -q my_errors.txt`) will jump to
" the first error in `my_errors.txt` (see [this StackOverflow answer for a
" good explanation][0]). This can be marginally useful, but I've never used
" it, especially because of LSPs and inline editor errors.
"
" `errorfile` effectively lets you specify a default `-q` argument. (This
" isn't *totally* true because `-q` sets this option and jumps to the first
" error.) I choose a reasonable default, but I'll probably never use this.
"
" [0]: https://stackoverflow.com/a/71129295
set errorfile=errors.err

" `:make`, `vim -q`, and a few other things use `errorformat`, which defines
" how errors should be found in the quickfix list. For example, you could do
" something like this:
"
"     gcc main.c 2> my_errors
"     vim -q my_errors
"
" If `errorformat` is set up correctly, it will jump to the first compiler
" error.
"
" I don't use this feature and the default, to quote Vim's docs, is "very
" long". So I don't set it. Maybe I'll start setting this if I start using
" this feature.

" When you press certain keys, such as the arrow keys, Vim receives them in a
" sequence. For example, pressing <Left> sends a sequence that starts with
" <Esc>. Therefore, for Vim to recognize that you've pressed the left arrow,
" it reads the <Esc> key and then waits a moment (`ttimeoutlen`) before
" deciding what to do.
"
" However, if you disable the `esckeys` option, it *won't* wait. That means
" that you can exit Insert mode instantly because the <Esc> will be instantly
" recognized...but special keys (like arrow keys) won't work in Insert mode
" any more.
"
" This option is exclusive to vanilla Vim, and I like it to be enabled there.
" After all, `ttimeoutlen` is pretty short, and I don't notice the difference.
if exists('+esckeys')
	set esckeys
endif

" I don't want to ignore any autocommand events, at least by default.
set eventignore=

" `eventignorewin` is window-local so I don't set it.

" Use real tabs. However, various `ftplugin`s may override this.
set noexpandtab

" Neovim's exrc option is safer because you have to explicitly trust a file
" (see `:help trust`). Vanilla Vim's is more dangerous, so we disable it
" completely. See `secure`.
if has('nvim')
	set exrc
else
	set noexrc
endif

" I don't want to set `fileencoding` because it's buffer-local. Setting this
" breaks if I use the `-M` flag.

" A list of character encodings that are tried. Try something that can detect
" a BOM, then UTF-8, then Latin-1. I expect everything I edit to be UTF-8.
set fileencodings=ucs-bom,utf-8,latin1

" `fileformat` dictates the EOL for the file. It is set automatically by
" `fileformats`. Setting it on a read-only buffer causes errors, so I don't
" specify it.

" Set the file format to "unix" unless every line ends in `\r\n`, and then
" choose "dos". I never edit "mac" files.
set fileformats=unix,dos

" `fileignorecase` is poorly described, but is well-described by [this Reddit
" post][0]. This option affects:
"
" - command line completion for `:edit`, `:find`, and others
" - insert mode completion with `<C-x><C-f>`
"
" It does not affect:
"
" - execution of `:edit`. On case-sensitive file systems, `:e foo` and
"   `:e FOO` are different.
" - `gf` in normal mode
"
" This may be an incomplete list, as I'm trusting a random person on the
" internet.
"
" Also, if enabled, `wildignorecase` is ignored.
"
" [0]: https://old.reddit.com/r/neovim/comments/16krfwz/
set fileignorecase

" `filetype` is buffer-specific and shouldn't be set here.

" `fillchars` dictates various characters that are used in various parts of
" the UI, such as split separators. I like most of the defaults in Neovim and
" vanilla Vim, so I don't set them here—after all, they're subtly different in
" ways I don't care to manage.
"
" - `eob` is the empty lines at the end of a buffer. Setting it to a space
"   makes the UI look a bit cleaner.
"
" - `lastline` changes the character displayed when the final line is
"   truncated. I like `...` for this. See `display`.
"
" - `vert` is the character that renders vertical splits. The Neovim default
"   is `│` (unless `ambiwidth` is `double`, which I don't do), but Vim's
"   is a simpler `|`, so I change it there.
set fillchars=eob:\ ,
if has('patch-9.0.0656')
	set fillchars+=lastline:.
endif
if !has('nvim')
	set fillchars+=vert:│
endif

" Control the behavior of `:find` (and similar commands like `:sfind`).
"
" By default, `:find` looks for files according to the `path` option. This
" works for files in the same directory, but doesn't go elsewhere. And as best
" I understand, it'll never find hidden files.
"
" This overwrites it to use the output of `git ls-files` (and tells it to
" include untracked-but-not-ignored files).
"
" I prefer to use the `fzf` plugin for this, but sometimes I'm not able to,
" and I fall back to using `:find` in those cases.
if exists('+findfunc')
	function! FindGitFiles(cmdarg, cmdcomplete) abort
		let fnames = systemlist('git ls-files --cached --directory --other --exclude-standard')
		if v:shell_error == 0
			return fnames->filter('v:val =~? a:cmdarg')
		else
			return []
		endif
	endfunction
	set findfunc=FindGitFiles
endif

" I don't want to add an <EOL> to the end of a file if it's missing. I don't
" want to change this value.
set nofixendofline

" I don't want folds to be automatically closed, so I set `foldclose` to an
" empty string.
set foldclose=

" `foldcolumn` is kinda neat: it draws a column that shows the depth of each
" fold, even if they're open. But I mostly think it adds visual
" clutter—code indentation does a lot of the work here—so I disable it.
set foldcolumn=0

" `nofoldenable` lets you disable folds. It seems useful if you want to
" quickly switch between "I have some folds set up just the way I like" and "I
" don't want to see any folds right now". I like the default, which lets me
" close folds as I wish.
set foldenable

" If I change `foldmethod` to `expr`, I can define an expression to evaluate a
" line's fold level. This is likely language-specific *and* I don't use this,
" so I set it to a value of "this line is not folded at all".
set foldexpr=0

" If I change `foldmethod` to `indent`, lines will be folded by indentation.
" In that situation, lines starting with `foldignore` (stripping trailing
" whitespace) get their fold level from surrounding lines. I could probably
" set some language-specific options for this, but I just leave it blank for
" now for simplicity.
set foldignore=

" I leave `foldlevel` unset, because it's window-local and changed by fold
" commands. But I set `foldlevelstart` to "no folds closed"; I don't want
" folds closed when I open a buffer.
set foldlevelstart=99

" If I change `foldmethod` to `marker`, these markers delimit folds. I don't
" do this, but if I do, I like this default.
set foldmarker={{{,}}}

" By default, I want syntax highlighting to be "in charge" of folds. (This is
" overridden by `vimdiff`, best I understand.)
set foldmethod=syntax

" Don't let me make one-line folds.
set foldminlines=1

" Set the maximum nesting of folds when using `syntax` or `indent`
" `foldmethod`s. 20 is Vim's internal maximum, which works for me. (Though if
" I have 20 levels deep...something is probably wrong.)
set foldnestmax=20

" If any of these things move the cursor into a closed fold, open the fold. I
" think most of them are pretty obvious from their names.
set foldopen=insert,mark,quickfix,search,tag,undo

" Show the first line of a fold (with syntax highlighting), rather than a
" slightly fancier format.
set foldtext=

" I don't specify the `fkmap` option because it doesn't exist in Neovim and
" was removed from vanilla Vim.

" Various formatter options are language-specific, so I don't set them here:
"
" - `formatexpr`
" - `formatlistpat`
" - `formatprg`

" Change how Vim formats text.
"
" - t: auto-wrap text with `textwidth`
" - c: auto-wrap comments with `textwidth`
" - q: allow formatting comments with `gq`
" - n: recognized numbered lists (see `formatlistpat`)
" - l: when a line is longer than `textwidth` when Insert started, don't
"   reformat it
" - j: remove comment leaders when joining lines
"
" The `j` check is lifted from [vim-sensible][0].
"
" [0]: https://github.com/tpope/vim-sensible/blob/0ce2d843d6f588bb0c8c7eec6449171615dc56d9/plugin/sensible.vim#L87-L90
set formatoptions=tcqnl
if v:version > 703 || v:version == 703 && has('patch541')
	set formatoptions+=j
endif

" Write files more reliably, but more slowly, with `fsync`.
"
" Note that this doesn't guarantee that the file will be written. To quote
" [SQLite's docs][0]:
"
" > Unfortunately, most consumer-grade mass storage devices lie about syncing.
" > Disk drives will report that content is safely on persistent media as soon
" > as it reaches the track buffer and before actually being written to oxide.
" > This makes the disk drives seem to operate faster (which is vitally
" > important to the manufacturer so that they can show good benchmark numbers
" > in trade magazines).
"
" [0]: https://sqlite.org/howtocorrupt.html
set fsync

" Enable global substitutes by default.
set gdefault

" The `:grep` command is controlled by `grepformat` and `grepprg`. Neovim
" changes its defaults based on whether `rg` is available, and its `grep`
" fallback is also good. Vanilla Vim's default is okay but can be easily
" updated to match Neovim's.
"
" `grepformat` is deliberately unset because it changes based on `rg`'s
" availability.
if !has('nvim')
	set grepprg=grep\ -HIn\ $*\ /dev/null
endif

" I let GUI Vim control these options because I don't use GUI Vim:
"
" - `guicursor`
" - `guifont`
" - `guifontwide`
" - `guioptions`
" - `guitablabel`
" - `guitabtooltip`

" I don't want to touch the help files, so I leave `helpfile` alone.

" Disable any minimum initial height of the help window.
set helpheight=0

" Always use English help files, because that's my preferred language.
if has('multi_lang')
	set helplang=en
endif

" Let me hide files without abandoning them. For example, if I modify `a.txt`
" but don't save it, I should still be able to open `b.txt`.
set hidden

" Save 1000 history commands and search patterns. See `messagesopt` for a
" similar option.
set history=1000

" `hkmap` and `hkmapp` do not exist in Neovim. They concern Hebrew text, which
" I don't use, so I didn't bother to understand what these options do. I leave
" them as their defaults. See `aleph`.

" `hl` is an option exclusive to vanilla Vim, and was removed in Neovim for a
" good reason: you shouldn't mess with built-in highlight groups. I don't
" touch this option and let vanilla Vim pick its default.

" Highlight all search matches, not just the current one.
if has('extra_search')
	set hlsearch
endif

" I don't want to change the window's icon text, so I disable `icon` and leave
" `iconstring` empty.
set noicon
set iconstring=

" Ignore case when searching, in command line completion, and in a few other
" places. Notably, it disrupts the Vimscript `==` operator, so you should use
" `==#` instead. See `smartcase`, which affects how this option works.
set ignorecase

" There are a bunch of Input Method options that I don't want to use, often
" because they're removed in Neovim. I disable as much of this as I can.
"
" `iminsert` and `imsearch` are a little different in that they can allow
" mappings with `:lmap` (and others, like `:lnoremap`). These language
" mappings apply " to Insert mode, Command-line mode, search patterns, and a
" few other places. I don't want any of this, so I disable them too. See
" `:help language-mapping`.
set iminsert=0
set imsearch=0
if !has('nvim')
	set imactivatefunc=
	set imactivatekey=
	set noimcmdline
	set imdisable
	set imstatusfunc=
	set imstyle=1
endif

" Show the effects of a command, such as `:s`, incrementally in a buffer.
if exists('+inccommand')
	set inccommand=nosplit
endif

" `include` and `includeexpr` are filetype-specific, so I don't set them here.

" If `incsearch` is enabled, your search starts as soon as you type. The
" matched string is highlighted (and all are highlighted if `hlsearch` is
" enabled), and you also scroll to the first match.
"
" If `incsearch` is disabled, your search starts when you press <Enter>, and
" nothing much happens while you type.
"
" I wish there were a convenient hybrid: highlight the search as you type, but
" don't jump until you press <Enter>. Maybe such a thing exists. But for now,
" I disable incremental search.
if has('extra_search')
	set noincsearch
endif

" `indentexpr` is powerful option that helps determine the proper indent for a
" line. According to `:help C-indenting`, this option is "the most flexible of
" all" the other indenting settings, and overrides `smartindent` and
" `cindent`.
"
" However, it's language-specific. For example, the value is
" `GetJavascriptIndent()` in JavaScript. So it doesn't really make sense to
" set here. Instead, rely on filetype-specific overrides, and other options
" (like `smartindent` and `cindent`) as fallbacks.
set indentexpr=

" `indentkeys` is a list of keys that causes re-indenting if typed in Insert
" mode. But similar to `indentexpr`, it's language-specific, so I don't set it
" to anything interesting here.
set indentkeys=

" Don't make Insert mode the default. No-op in Neovim, where the option
" doesn't exist.
if has('vim_starting')
	set noinsertmode
endif

" You can do "keyword completion" in Insert mode. CTRL-N is how I use this
" most often, but you can also do dictionary completion (CTRL-X CTRL-K) and a
" few others.
"
" "When doing keyword completion in insert mode, and `ignorecase` is also on,
" the case of the match is adjusted depending on the typed text." I don't
" want this in code files, so I disable it here. However, I *do* enable it in
" plain text and Markdown files.
set noinfercase

" `isfname` specifies the characters included in file and path names. These
" are used for `gf`, among other things. The default changes based on the OS
" and locale. I'm happy with the default so I leave it alone.

" The `isident` option controls identifiers, which "are used in recognizing
" environment variables and after the match of the `define` option." I don't
" set this because (1) the default is reasonable (2) the default varies by OS
" (3) the docs warn that changing it could break environment variables.

" `iskeyword` is language-specific, but here's a reasonable default value in
" case it's not set.
set iskeyword=@,48-57,_,192-255

" These characters are always displayed directly on the screen. The option
" only affects code points between 0 to 31 and 127 to 255, inclusive. See
" `display`'s `uhex` option.
set isprint=161-255

" Insert just one space after a join.
set nojoinspaces

" To quote `:help jump-motions`, "A 'jump' is a command that normally moves
" the cursor several lines away", such as `123gg` or `n`. (For a full list of
" jumps, see `:help jump-motions` or [this post][0].)
"
" When you jump, Vim saves it to the jumplist's window. You can use CTRL-O
" and CTRL-I to navigate the list.
"
" `jumpoptions` changes the behavior of the jumplist, but I don't change any
" of it!
"
" - `stack` makes the jumplist behave like a stack, not a list. I think [this
"   comment][1] and [this question][2] demonstrate the difference better than
"   I can, but I'll try anyway:
"
"   This option affects what happens when you jump back (with CTRL-I) and then
"   make another jump. In `stack` mode, everything later in the stack will be
"   deleted, and you'll start a new "timeline" of jumps. Otherwise, nothing
"   will be cleared.
"
"   The `stack` option is probably more intuitive, but I use the jumplist as
"   a useful way to hop around places I've been. I don't want to lose a
"   bookmark, so I don't set this option.
"
" - `view` attempts to reconstruct the view you had when the jump was made.
"   For example, if you were on line 123 and it was in the middle of the
"   screen, jumping back will try to put line 123 back in the middle of the
"   screen. This is another option that makes sense to me, but I don't like
"   it, so I don't set it. Best I understand, this is a Neovim exclusive.
"
" - `clean` is prunes unloaded buffers from the jumplist. I want this option!
"   But I don't set it here because (1) it's marked experimental, so I don't
"   want to mess with it (2) it's already the default value, so I get it with
"   no effort (3) it's a Neovim exclusive, so I don't have to mess with a
"   vanilla Vim compatibility check.
"
" In summary, `jumpoptions=clean` in Neovim and `jumpoptions=` in vanilla.
"
" [0]: https://codeinthehole.com/tips/vim-lists/#jump-list
" [1]: https://old.reddit.com/r/neovim/comments/16nead7/comment/k1e1nj5/
" [2]: https://vi.stackexchange.com/q/18344

" Neovim removed encryption support. Vanilla Vim warns that you shouldn't
" touch the `key` value, so I don't set it at all. See also: `cryptmethod`.

" I don't use any keyboard mapping, because I usually type ASCII. And when I
" type in another language, I don't want to use Vim's key mapping. See
" `langmap`.
set keymap=

" Hold Shift and press <PageUp>, <PageDown>, <Home>, <End>, or an arrow key.
" This will start a selection (that's `startsel`). I like this because it
" feels a little more like non-Vim text editing, like in other parts of the
" operating system.
"
" I don't add the `stopsel` flag because it sometimes causes selections to
" stop, like if you have a visual selection and then press CTRL-F.
set keymodel=startsel

" TODO: keywordprg

" `keyprotocol` was removed from Neovim. I don't understand what this option
" does or why it was removed, and I didn't check. I just leave it alone.

" Translate Normal mode keys into other Normal mode keys. For example,
" `set langmap=aA` runs `A` when you type `a` in Normal mode. I'd maybe want
" to set this if I were frequently using a non-English keyboard? `:nnoremap`
" is much better for me, so I disable this. See `keymap`.
set langmap=

" Always use English menus, because that's my preferred language.
set langmenu=none

" I don't use `langmap`. But even if I did, I'd want this setting to be off:
" characters resulting from a mapping shouldn't affect `langmap`.
if exists('+langremap')
	set nolangremap
endif

" Always show the status line, which has a bunch of useful information. See
" `statusline`.
set laststatus=2

" Redraw the screen in more situations, because enabling it "my occasionally
" cause display errors. It is only meant to be set temporarily".
set nolazyredraw

" Wrap long lines at `breakat`, not (just) the last character that fits on the
" screen. This makes line breaks easier to read, especially with prose.
set linebreak

" In terminal Vim, `lines` is set by the terminal, so I shouldn't set it. In
" GUI Vim, which I don't use, I'll trust whatever default they give. See
" `columns`.

" Change the height of lines in GUI Vim. I don't use GUI Vim *and* 0 seems
" like a reasonable value, so I set it to 0.
set linespace=0

" `lisp` is language-specific so I don't set it here.

" If `lisp` is enabled, use `indentexpr`.
if exists('+lispoptions')
	set lispoptions=expr:1
endif

" `lispwords` is language-specific so I don't set it here.

" Don't show invisible characters by default (though I often turn this on
" manually). See `listchars`.
set nolist

" When `list` is enabled (or with the `:list` command), show tabs, EOLs,
" trailing white space, and invisible non-breaking space characters.
set listchars=tab:▸\ ,eol:¬,trail:·,nbsp:□

" I'd like plugins to be loaded.
set loadplugins

" `luadll`, which is exclusive to vanilla Vim, should come from the build. I
" don't want to set it.

" I don't want to change the special characters that can be used in search
" patterns. "Switching this option off most likely breaks plugins", according
" to Vim's docs, and I'm happy with it being on.
set magic

" I'd like `:make` and `:grep` to use Vim-generated temp files. I don't want
" to name them.
set makeef=

" I don't completely understand `makeencoding`. It says that it's the
" "encoding used for reading the output of external commands", which I think
" makes sense. But when it's empty, "encoding is not converted". It goes on to
" explain an arcane case where this is useful.
"
" Until this causes me problems, I'm leaving this empty.
set makeencoding=

" `makeprg` is language-specific, so I don't set it.

" Set the characters that form pairs for the `%` command and `matchit` plugin.
" This is usually language-specific, but this is a reasonable default. (Also,
" I can't seem to get `matchit.vim` to work in vanilla Vim.)
set matchpairs=(:),{:},[:]

" I disable `showmatch`, but if I didn't, I'd want the jump to be brief.
set matchtime=5

" "The maximum number of combining characters supported for displaying." This
" Unicode-related option is exclusive to vanilla Vim, where it stops combining
" code points into a single glyph after awhile. In Neovim, this is calculated
" with bytes, and is "guaranteed" to be compatible with vanilla Vim setting
" this to 6.
set maxcombine=6

" Maximum depth of function calls for user functions, which probably catches
" out-of-control recursion. Vim's default is 100, which is fine with me. For
" reference, Python's `sys.getrecursionlimit()` on my machine is `1000`.
set maxfuncdepth=100

" Maximum number of times a mapping can happen without doing anything, which
" probably catches endless mappings like `:map a b` + `:map b a`. I usually
" prefer "no remap" variants like `:nnoremap`. Vim's default is 1000, but I
" lower it because I want to catch cases where I'm doing this by mistake.
set maxmapdepth=10

" Vanilla Vim lets you limit memory to use for a single buffer with `maxmem`.
" This is system-dependent *and* not supported in Neovim, so I don't set it.

" Don't allow more than a megabyte of memory to be used for pattern matching.
" This usually means there's some scary, inefficient pattern.
set maxmempattern=1000

" Vanilla Vim lets you limit memory to use for all buffers with `maxmemtot`.
" From the docs, it's unclear what happens when you hit this limit. Like
" `maxmem`, this is system-dependent and missing in Neovim, so I skip it.

" TODO: I don't understand what this option does, but I set it to its default.
set menuitems=25

" When a message is output, prompt the user to press Enter. Also, save a bunch
" of history, which you can see with `:messages`.
if exists('+messagesopt')
	set messagesopt=hit-enter,history:1000
endif

" The `:mkspell` command generates a Vim spell file from a word list. For
" example, `mkspell /tmp/spell.spl /usr/share/dict/words`. The `mkspellmem`
" gives you some control of the memory and CPU use of that command. I think
" the docs are pretty clear so I won't describe it further.
"
" On my computer, running the example above used about 2.2 megabytes of
" memory, which isn't much. It might become important if I use a different
" language (the docs call out Italian and Hungarian).
"
" Let's just use the example from the Vim docs, which assumes I have a
" gigabyte of RAM. I could probably tune this to perfection, but to what end?
if has('syntax')
	set mkspellmem=900000,3000,800
endif

" I never use these. Better to disable them and some of their options.
set nomodeline
set nomodelineexpr
set modelines=0

" `modifiable` and `modified` are buffer-local flags that aren't really
" configuration options, so I don't set them here.

" Use Vim's built-in pager when messages fill the screen. See `:help pager`
" for usage instructions. In my opinion, this pager is pretty flimsy, but it's
" better than the alternative: dumping everything to the screen with no
" paging.
set more

" Enable mouse support in Normal, Visual, and Insert mode. I don't enable it
" in Command-line mode because I don't want it, nor in the pager or hit-enter
" prompts because they're weird there.
set mouse=nvi

" When `mousefocus` is on, windows are automatically focused when you hover
" over them. I don't want this.
set nomousefocus

" If I ever use GUI Vim, hide the mouse pointer while typing.
set mousehide

" This basically makes right-click open a popup menu (`popup`) and move the
" cursor to where you clicked (`setpos`). It also changes the behavior of
" left-click + shift. See `:help 'mousemodel'` for an overview.
set mousemodel=popup_setpos

" When `mousemoveevent` is on, mouse move events are registered and you can do
" stuff when that happens. I don't care about this so I disable it.
if exists('+mousemoveevent')
	set nomousemoveevent
endif

" When using the scroll wheel, scroll as slowly as possible.
"
" Horizontal scrolling only works if `nowrap` is set, and doesn't seem
" supported in terminal Neovim based on the docs. But why not set it?
if exists('+mousescroll')
	set mousescroll=ver:1,hor:1
endif

" Vim can change the mouse cursor based on what's happening...in theory. In
" practice, (1) this is [unimplemented in Neovim][0] (2) seems to be
" [exclusive to Windows and X11 builds of vanilla Vim][1], which I don't use.
"
" I could set the `mouseshape` option, but I wouldn't be able to test the
" results. Consistent with my general omission of other GUI options, I'm
" leaving it unset.
"
" [0]: https://github.com/neovim/neovim/issues/21458
" [1]: https://stackoverflow.com/a/38283488/804100

" How quickly do you need to click twice for it to register as a double-click?
set mousetime=400

" `mzschemedll` and `mzschemegcdll` are exclusive to vanilla Vim, and should
" come from the build. I don't want to set them.

" CTRL-A and CTRL-X add and subtract from numbers.
"
" - `hex` adds support for hexadecimal numbers like `0x45`.
" - `bin` adds support for binary numbers like `0b1000101`.
" - `blank` ignores leading dashes based on preceding whitespace. The docs at
"   `:help nrformats` have a good example of how this works. If not supported,
"   `unsigned` is a reasonable fallback.
if has('patch-9.1.0537')
	set nrformats=hex,bin,blank
else
	set nrformats=hex,bin,unsigned
endif

" Show line numbers. Because I've also enabled `relativenumber`, enabling this
" only does one thing: show the current line number on the cursorline.
" Everything else is handled by `relativenumber`.
" `:help number_relativenumber` for more.
set number

" The line number column should be as small as possible.
set numberwidth=1

" `omnifunc` is typically set by a language plugin, so I don't set it here.

" Disable reading and writing from devices. This is a no-op in Neovim.
set noopendevice

" I haven't used the `g@` operator. Maybe I will someday, but until then, I
" don't need the operator function.
set operatorfunc=

" `osfiletype` is exclusive to vanilla Vim and is removed there, so I don't
" set it at all.

" I don't want to change Vim's `packpath`.

" Vim has a paragraph object. You can move around them with `{` and `}`,
" delete a paragraph with `dap`, and so on. These are controlled with nroff
" macros, like "PP" for "begin a new paragraph". I don't know much about nroff
" so I don't set the `paragraphs` option.

" The `paste` flag is exclusive to vanilla Vim. It's useful when you want to
" paste text into Vim and avoid various issues, like auto-indenting. I prefer
" it to be off by default, unless I'm pasting. I also disable any paste
" toggling key.
"
" Neovim's docs cheekily say "Just Paste It.™" You don't have to think about
" this option there.
if !has('nvim')
	set nopaste
	set pastetoggle=
endif

" Applying patches should use the default: calling the `patch` program. I
" don't want to use a custom diff patcher.
set patchexpr=

" I don't want to save old versions of files. See `backup` and `writebackup`.
set patchmode=

" `path` is used for various things, including `gf`. It's also used for
" `:find` by default, but that's not relevant because I set `findfunc`.
"
" I'd like to use the current directory and its children for this purpose.
" Recurse up to 16 subdirectories. See `:help file-searching`.
set path=**16

" `perldll`, which is exclusive to vanilla Vim, should come from the build. I
" don't want to set it.

" When changing the indent of a line, "the indent is replaced by a series of
" tabs followed by spaces as required (unless 'expandtab' is enabled, in which
" case only spaces are used)." Similar to `copyindent`, but only for the
" current line.
set nopreserveindent

" TODO: `previewheight`, `previewpopup` (vanilla exclusive but "not yet
" implemented" in Neovim).

" The `previewwindow` option is "normally not set directly, but by using one
" of the commands `:ptag`, `:pedit`, etc." Therefore, I don't want to set it
" here.

" Vanilla Vim has it all, including printer functionality with the `:hardcopy`
" command. It has a bunch of options, all of which have reasonable default
" values, so I don't set them. (Neovim has no such feature.) I skip:
"
" - `printdevice`
" - `printencoding`
" - `printexpr`
" - `printfont`
" - `printheader`
" - `printmbcharset`
" - `printmbfont`
" - `printoptions`

" Show a `:` in Ex mode. This is a no-op in Neovim; it is always on.
set prompt

" No transparency for the popup menu.
if exists('+pumblend')
	set pumblend=0
endif

" Popup menus should use the available screen space.
set pumheight=0

" Popup menus should be at least 20 characters wide.
set pumwidth=20

" Vanilla Vim supports Python plugins, but differently from how Neovim does.
" Rather than try to support it, I leave the following options unset:
"
" - `pythondll`
" - `pythonhome`
" - `pythonthreedll`
" - `pythonthreehome`

" Specify the Python version for Python commands. In Neovim, "setting any
" other value [than 3] is an error". In vanilla Vim, this option is used when
" both Python 2 and Python 3 support is baked in, and otherwise "has no
" effect".
if has('neovim') || has('python3')
	set pyxversion=3
endif

" TODO: quickfixtextfunc

" Backslashes are escape quotes in strings. This may be overwritten by a
" language-specific setting.
set quoteescape=\\

" `readonly` is not really a configuration option, so I don't set it here.

" I don't want to debug the way redrawing works, so I leave this option empty.
if exists('+redrawdebug')
	set redrawdebug=
endif

" If it takes longer than this to redraw, give up. This affects highlighting
" searches (see `hlsearch`), syntax, `inccommand`, and more.
if has('reltime')
	set redrawtime=1000
endif

" Vim has two regexp engines: an old engine that "supports everything" and a
" new one that "works much faster on some patterns" but is "possibly slower"
" in some cases. Let Vim automatically pick the right one.
set regexpengine=0

" Show line numbers relative to the cursor. This makes it much easier to do
" relative motions because I don't have to do any mental math. See `number`
" and `:help number_relativenumber`.
set relativenumber

" Allow mappings to work recursively in vanilla Vim (Neovim has removed this
" option). Vim's docs recommend always keeping this on, so I will.
set remap

" `renderoptions` only affects the GUI (which I don't use) and Windows (which
" I use in a pinch) on vanilla Vim (which I rarely use). I'll trust the
" default value here and leave it unset.

" Always report the number of lines changed.
set report=0

" `restorescreen` is a Windows-only option exclusive to vanilla Vim. I'll
" trust the default value here and leave it unset.

" Disable Reverse Insert mode.
set norevins

" Disable right-to-left, because I don't edit those languages. See `arabic`.
" And if I ever enable right-to-left mode, I want to allow right-to-left text
" in search.
if has('rightleft')
	set norightleft
	set rightleftcmd=search
endif

" `rubydll`, which is exclusive to vanilla Vim, should come from the build. I
" don't want to set it.

" Disable the ruler. I do something very similar in the status line, so I
" don't need this. See `statusline`.
set noruler
set rulerformat=

" I don't want to mess with `runtimepath`, so I don't set it.

" CTRL-U and CTRL-D should scroll just a little. If you're on a very short
" window, this can fail.
try
	set scroll=10
catch /^Vim\%((\a\+)\)\=:E49:/
endtry

" Save several lines in terminal buffers. I don't use Neovim's terminal much,
" so I don't need this to be very big.
if exists('+scrollback')
	set scrollback=1000
endif

" Don't bind scrolling. This gets overridden in diff mode (`nvim -d`). See
" `cursorbind`.
set noscrollbind

" This option is exclusive to vanilla Vim + GUI + Windows. In that case, I'd
" want scrolling to affect where the mouse cursor is, not the current window.
" ("Systems other than MS-Windows always behave like this option is on.")
if exists('+scrollfocus')
	set scrollfocus
endif

" When I'm scrolling new lines into view, I want them to appear as smoothly as
" possible. Setting `scrolljump` to 1 achieves that. A higher number causes
" scrolling to, well, jump. And I don't like that because I think it's harder
" to follow.
set scrolljump=1

" Keep 4 lines above and below the cursor when scrolling. See `sidescrolloff`
" for the horizontal version.
set scrolloff=4

" Specify how scroll bound windows (`scrollbind`) behave. TODO: Explain why I
" include `jump`
set scrollopt=ver,jump

" This is irrelevant in Neovim. In vanilla Vim, it should also be irrelevant
" if `exrc` is disabled, which I do. Just in case, I set it anyway.
set secure

" Vim has a section object. You can move around them with various commands, I
" suppose, but I haven't found this to be very useful. In any case, I don't
" know much about how they're configured (using nroff macros), so I leave the
" `sections` option alone.

" In Visual and Select mode, I (1) want the selection to include the last
" character of the selection (2) don't want to be able to select one character
" past the end of the line. `old` is how I achieve that.
set selection=old

" Select mode like Visual mode, but just a little bit different. Best I
" understand from the docs and [this Stack Exchange answer][0], it's made to
" resemble the selection mode from other environments. See `:help Select-mode`
" for details.
"
" I'm happy with Visual mode, so I don't ever want to activate Select mode.
" See also: `keymodel`.
"
" [0]: https://vi.stackexchange.com/a/4892
set selectmode=

" You can save Vim's state and restore it later. To save the state, use
" `:mksession`. I want to save the following when I save a session:
"
" - all windows: `blank` windows, hidden and unloaded `buffers`, `help`
"   windows, `tabpages`s and `terminal`s, and their sizes
" - the current directory
" - fold state
"
" I don't want to save `runtimepath` or `packpath`.
set sessionoptions=blank,buffers,curdir,folds,help,skiprtp,tabpages,terminal,winsize

" Neovim lets you save certain things to a shared data file (also known as
" ShaDa). I want to save:
"
" - a list of previously edited files and jumplist (`'`)
" - a list of previous searches (`/`)
" - some data for registers (`<`)
" - no `hlsearch` effect
" - up to 5KiB for each
"
" I don't specify the `:` because that uses the value from `history`.
if has('shada')
	set shada='100,/10,<50,h,s5
	let &shadafile = stdpath('state') . '/shada'
endif

" TODO: shell*
set noshelltemp

" `shellslash` uses forward slashes when expanding file names. I want this
" enabled on Unix and disabled on Windows, which is exactly Neovim's behavior.
" Vanilla Vim behaves slightly differently, but I'm happy with that too.
" Therefore, I don't set this option.

" When indenting, round to a multiple of `shiftwidth`.
set shiftround

" TODO: Explain this option (and maybe change it?)
set shiftwidth=2

" TODO: shortmess

" Don't assume filenames are 8 characters with a 3-character extension. I
" don't use systems like this. (This option is only in vanilla Vim.)
if exists('+shortname')
	set noshortname
end

" When a long line is wrapped, show this at the indentation. See
" `breakindent`.
set showbreak=

" TODO: explain this
set showcmd

" TODO: showcmdloc

" TODO: showfulltag

" When `showmatch` is enabled, inserting a bracket (like `{`) will briefly
" jump to the matching one if it exists. I don't want this, especially because
" it's already highlighted, so I disable it. See `matchtime`.
set noshowmatch

" Show a message in Insert, Replace, and Visual modes. For example, Insert
" mode shows `-- INSERT --` at the bottom. If `cmdheight` is 0, does nothing.
set showmode

" Hide the tab line if there's only one tab.
set showtabline=1

" TODO: Explain this
set sidescroll=1

" The horizontal version of `scrolloff`.
set sidescrolloff=15

" Lines can have signs. For example, an × symbol for an error. (See `:help
" sign.txt` for more details.) You'll see this column next to the line
" numbers. I only want this column when there's a sign.
set signcolumn=auto

" Search should be case-sensitive if the search pattern contains uppercase.
set smartcase

" Typically overridden by `indentexpr`. See comment in `cindent`.
set nosmartindent

" TODO: smarttab

" Let's say the top of your window has a source line that's long, and it wraps
" to two screen lines (`wrap` is on). Now, you scroll one line down.
"
" Without `smoothscroll`, the top source line will be skipped, which skips
" *two* screen lines. With `smoothscroll`, the window will scroll down by just
" one screen line. As the name implies, makes scrolling smoother.
"
" The docs say that it doesn't yet work with `gj`, which I typically use as an
" alias for `j` (see mappings below). So this is most noticeable when I scroll
" with a mouse wheel.
if exists('+smoothscroll')
	set smoothscroll
endif

" TODO: Explain this, and maybe change it
set softtabstop=2

" Set various spell checking options.
"
" - Disable spell checking by default (though I often enable it manually).
" - Locate the end of a sentence, to ensure that the next word starts with a
"   capital letter.
" - Put the spell file in the state folder, similar to `directory` or
"   `backupdir`.
" - Use American English for spell checking, because that's what I use the
"   most.
" - Check `CamelCased` words separately. This may be overwritten by a
"   language-specific plugin.
" - When suggesting spelling improvements (typically with `z=`), use an
"   English-optimized checker, only show 7 suggestions, and don't take more
"   than 3 seconds to find the suggestions.
if has('spell')
	set nospell
	set spellcapcheck=[.?!]\_[\])'"\t ]\+
	if has('nvim')
		let &spellfile = stdpath('state') . '/spellfile.' . &encoding . '.add'
	else
		silent! execute '!mkdir -p ' . expand('$HOME/.vim')
		let &spellfile = expand('$HOME/.vim/spellfile.') . &encoding . '.add'
	endif
	set spelllang=en_us
	set spelloptions=camel
	set spellsuggest=best,7
	if has('reltime') && has('patch-8.2.4249')
		set spellsuggest+=timeout:3000
	endif
endif

" New splits should go below the current one.
set splitbelow

" When splitting, don't move the cursor.
if exists('+splitkeep')
	set splitkeep=cursor
endif

" New vertical splits should go to the right of the current one.
set splitright

" When going to a new line in many cases (like `:25`, `gg`, `dd`), move the
" cursor to the first non-blank of the line. Without this, the cursor will be
" kept in the same column when possible.
set startofline

" TODO: statuscolumn (doesn't look like it's in vanilla Vim)

" TODO: Explain this
set statusline=\ %f\ %*%<\ %m\ %=%l:%c/%L\ \ %p%%\ %r

" TODO: suffixes

" `gf` opens the file under the cursor. `suffixesadd` lets you add suffixes to
" that. for example, in javascript, `import * from './foo'` could jump to
" `./foo.js` if `suffixesadd` has `.js` in it. i want this for different
" languages, but i can't set it here because it's language-specific.

" When you're editing a file, Vim creates a parallel swap file. This file
" serves two purposes:
"
" - If you're editing the same file in multiple Vim instances, you'll get a
"   warning.
" - If Vim crashes, you can recover your work. I save often so I don't find
"   this very useful, but maybe it'll come in handy one day.
"
" I enable this feature. Also see `directory`, `updatecount`, and
" `updatetime`.
set swapfile

" Vanilla Vim lets you control whether swapfiles are synced to disk when
" written, similar to `fsync`. This option does not exist in Neovim.
"
" It seems this option can be set to three values:
"
" - `fsync`, which does an `fsync()` call
" - `sync`, which does a `sync()` call
" - empty, which just does a regular write
"
" I liked [this general non-Vim summary on Stack Overflow][0].
"
" This decision affects the reliability and performance of writing swap files.
" It probably doesn't make much difference.
"
" If I disable syncing, I'd run into problems if I have an unsaved change in a
" swap file that wasn't persisted to disk, and then the whole computer would
" have to crash. *And* I'd have to be using vanilla Vim, not Neovim, which I
" don't normally use.
"
" If I enable syncing (either `fsync` or `sync`), swapfile writes, which are
" frequent, will be slower.
"
" Here's what I figure: if I'm using vanilla Vim, I'm probably on a slower
" computer. Maybe I'm on an old laptop or a lower-resource virtual machine.
" So I disable syncing for performance.
"
" [0]: https://stackoverflow.com/a/48172224/804100
if exists('+swapsync')
	set swapsync=
endif

" TODO: switchbuf

" Vim has two options for the current language: `filetype` and `syntax`. I'm
" not sure, but I believe `syntax` only affects syntax highlighting while
" `filetype` affects other things. I'd like to keep these values in sync,
" which I believe Vim does by default. Also, older versions of Vim give a
" "filetype unknown" error when reading an empty filetype (e.g., by just
" running `vim`). So I don't set this option.

" Don't do syntax highlighting for long lines. I notice this most often when
" I'm opening a minified JavaScript file.
set synmaxcol=500

" When closing a tab page, go to the next tab page.
if exists('+tabclose')
	set tabclose=
endif

" TODO: tabline

" TODO: explain this, maybe see similar window option
set tabpagemax=25

" TODO: Explain this (and maybe change it)
set tabstop=2

" I don't use tags and prefer to use an LSP for everything. Therefore, I skip
" setting the following options:
"
" - `tagbsearch`
" - `tagcase`
" - `tagfunc`
" - `taglength`
" - `tagrelative`
" - `tags`
" - `tagstack`

" `tcldll`, which is exclusive to vanilla Vim, should come from the build. I
" don't want to set it.

" Vanilla Vim has several options to configure how it runs in the terminal
" (not to be confused with any built-in terminals). I don't want to touch
" these. I skip `term` and `termencoding` for that reason, as well as all the
" `t_` options.

" I don't expect my terminal to be in right-to-left mode, so I disable it.
" This might be wrong, but I'll cross that bridge if I ever start editing RTL
" text in Vim.
set notermbidi

" The `termguicolors` option enables rich colors (24-bit RGB) in the terminal,
" and uses GUI highlight groups instead of terminal highlight groups. I don't
" set this option because (1) I use a default color scheme which works fine in
" the terminal, so I don't need it (2) Neovim will set this automatically for
" me (3) I have a weak understanding of terminal colors so I don't want to
" mess anything up.

" When pasting, ignore various control characters. Only tab should be
" supported.
if exists('+termpastefilter')
	set termpastefilter=BS,FF,ESC,DEL,C0,C1
endif

" Vsync, but for Neovim.
if exists('+termsync')
	set termsync
endif

" I don't want to touch vanilla Vim's terminal, so I skip `termwinkey`,
" `termwinscroll`, `termwinsize`, and `termwintype`.

" Vanilla Vim's `terse` option adds the `s` flag to `shortmess`. Instead of
" setting it, I should just set `shortmess`. (This option is removed in
" Neovim.)

" Vanilla Vim has two obsolete text options, `textauto` and `textmode`, which
" have been superseded by `fileformats` and `fileformat`. I don't set them.

" `textwidth` is a buffer option, so I don't set it here.

" Vim has a thesaurus, which can be activated with <C-X><C-T>. I implement
" this in Neovim (see Neovim-specific initialization Lua file). I don't think
" it's worth initializing in vanilla Vim, though, so I set these to empty and
" later override them in Neovim-land.
set thesaurus=
set thesaurusfunc=

" The tilde command (`~`) really should behave like an operator, but I'm so
" used to how it works that I keep it at the default: off.
set notildeop

" If I start typing a mapping and then wait more than 3 seconds, I want that
" to time out. See `ttimeout` and `timeoutlen`.
set timeout
set timeoutlen=3000

" I don't care to set the window title, so I disable as much of it as I can,
" or set the values to reasonable defaults.
set notitle
set titlelen=72
set titleold=
set titlestring=

" If I start typing a key sequence and then wait more than 50 milliseconds, I
" want that to time out. This is a smaller number because many key sequences
" are me logically pressing a key, but the terminal receiving multiple keys.
" See `timeout` and `ttimeoutlen`.
set ttimeout
set ttimeoutlen=50

" Vanilla Vim has two options, `toolbar` and `toolbariconsize`, which control
" some GUI toolbar settings. I don't use GUI Vim, so I don't set these.

" Vanilla Vim has several TTY options I don't want to touch. They are
" `ttybuiltin`, `ttyfast`, `ttymouse`, `ttyscroll`, and `ttytype`.

" In Neovim, store undo files in the state folder. In vanilla Vim, use a
" folder in `~/.vim`. See `undofile`.
if has('nvim')
	let &undodir = stdpath('state') . '/undo//'
else
	silent! execute '!mkdir -p ' . expand('$HOME/.vim/undo/')
	let &undodir = expand('$HOME/.vim/undo//')
endif

" Save undo history in `undodir`.
set undofile

" Let me undo up to 100 changes.
set undolevels=100

" When reloading a file, save the whole buffer for undo. This happens when
" using `:e!` or when the buffer is changed outside of Vim. Only save the
" first 20K lines. (Vim isn't great for editing large files, so I don't need a
" huge number here.)
set undoreload=20000

" Write the swap file after typing this many characters. Because I save often
" and `updatetime` is reasonably low, it should be fine to set this to a
" fairly large number. See `swapfile`.
set updatecount=65535

" Update the swap file after this amount of idle time. Also affects the
" `CursorHold` autocmd. See `updatecount` and `swapfile`.
set updatetime=1000

" I don't want (soft) tabs to render at different widths, at least by default.
" Therefore, I don't se `varsofttabstop` or `vartabstop`, and just rely on
" `softtabstop` and `tabstop`.

" Disable tracing and verbosity. Neovim and vanilla Vim behave differently
" here, but `verbose=0` should work the same on both. I might want to set
" these if I'm debugging something.
set verbose=0
set verbosefile=

" Where should I store `:mkview` files? I don't really use this feature. But
" in Neovim, store `:mkview` files in the state folder. In vanilla Vim, use a
" folder in `~/.vim`. I don't use this feature much, but I set it anyway.
if has('nvim')
	let &viewdir = stdpath('state') . '/view//'
else
	silent! execute '!mkdir -p ' . expand('$HOME/.vim/view/')
	let &viewdir = expand('$HOME/.vim/view//')
endif

" What should `:mkview` save? I don't really use this feature, but if I do, I
" want to save:
" - the current cursor position
" - fold state
set viewoptions=cursor,folds

" Neovim has ShaDa, vanilla Vim has `viminfo`. I just disable it.
if has('viminfo')
	set viminfo=
	set viminfofile=NONE
endif

" I never want the cursor to be "where there is no actual character". Relates
" a bit to `selection`.
set virtualedit=none

" Ring an audio bell. See `belloff`.
set novisualbell

" "Give a warning message when a shell command is used while the buffer has
" been changed." It seems that this logs "[No write since last change]" in
" this case. I want that, just in case I'm operating on the current file and
" haven't saved it.
set warn

" `weirdinvert` is a terminal-related option in vanilla Vim. I don't want to
" touch any of these options. See `term` and others.

" Allow <Left> and <Right> arrow keys to change lines in Insert and Replace
" modes.
set whichwrap=[]

" Command line completion should use tab.
set wildchar=<Tab>

" If you're using a macro and want to press `wildchar` (<Tab>) to activate
" command line completion, you can't. For example, you can't do something like
" this:
"
"     cnoremap foo edit <Tab>
"
" That's where `wildcharm` comes in. Instead of `<Tab>` in the mapping above,
" you can assign it to some other value and then use that in your macros. I
" chose <C-@> because it's unused according to `:help ex-edit-index`. So your
" macro would now be:
"
"     cnoremap foo edit <C-@>
"
" As of this writing, I haven't made any of these mappings...but now I can!
set wildcharm=<C-@>

" Files matching these patterns should not show up in autocomplete (and a few
" other places).
set wildignore+=*.7z
set wildignore+=*.dll
set wildignore+=*.exe
set wildignore+=*.gif
set wildignore+=*.jpeg
set wildignore+=*.jpg
set wildignore+=*.o
set wildignore+=*.obj
set wildignore+=*.out
set wildignore+=*.pdf
set wildignore+=*.png
set wildignore+=*.pyc
set wildignore+=*.pyo
set wildignore+=*.rar
set wildignore+=*.swp
set wildignore+=*.tar
set wildignore+=*.tar.bz2
set wildignore+=*.tar.gz
set wildignore+=*.tar.xz
set wildignore+=*.tgz
set wildignore+=*.tiff
set wildignore+=*.zip
set wildignore+=.DS_Store
set wildignore+=.git
set wildignore+=.vscode
set wildignore+=__pycache__

" `wildignorecase` "has no effect when `fileignorecase` is set". I set it here
" in case I disable `fileignorecase`.
set wildignorecase

" Enhance command-line completion. See many of the other `wild` options.
set wildmenu

" When hitting `wildchar` (<Tab>), show a little bar with a bunch of options I
" can choose from.
set wildmode=full

" Command line completion show the kind and location of tags, but none of the
" other stuff.
set wildoptions=tagfile

" On Windows, I think you can use the Alt key to select things in menus. I
" don't want this in GUI Vim (not that I ever use this), so I disable it.
set winaltkeys=no

" I don't want a bar at the top of every window.
if exists('+winbar')
	set winbar=
endif

" The floating window should be opaque.
if exists('+winblend')
	set winblend=0
endif

" Floating windows should have no border.
if exists('+winborder')
	set winborder=none
endif

" `wincolor` changes the default highlight group. Not only is it missing from
" Neovim, it's also window-local. I don't set it. Also see `winhighlight`.

" `window` is relative to screen height, which I can't know at configuration
" time. I skip it.

" `winfixbuf` pairs the window and the buffer. Based on my understanding of
" the docs and [this post][0], this means that you can't change the window's
" buffer. This could be useful for various plugins, and I don't think it's my
" responsibility to set it in my configuration.
"
" [0]: https://old.reddit.com/r/neovim/comments/1bbuh3z/

" `winfixheight` and `winfixwidth` are window-local options that keep a
" window's dimensions even if something else tries to resize them, like with
" `equalalways` or `CTRL-W_=`. I might want to set these manually, but I don't
" think I should set them in my config.

" The current window has to be at least one line tall. See also
" `winminheight`.
set winheight=1

" I don't want to change any window-local highlights.
if exists('+winhighlight')
	set winhighlight=
endif

" Let non-current windows be squashed. They'll always show a status bar and
" vertical separator.
set winminheight=0
set winminwidth=0

" `winptydll`, which is exclusive to vanilla Vim, should come from the build.
" I don't want to set it.

" The current window has to be at least a few characters wide. See also
" `winminwidth`.
set winwidth=5

" Wrap long lines. (This only affects display, not the source.)
set wrap

" No padding when wrapping long lines; characters should go against the edge
" of the window.
set wrapmargin=0

" Searches should not wrap around the end of a file. Neither should spelling
" mistake hunts like `]s`.
set nowrapscan

" Files should be writeable by default. This can be disabled, like if editing
" a read-only file.
set write

" I shouldn't be able to write read-only files without using `:w!`.
set nowriteany

" See comment in `backup`.
set writebackup

" `writedelay` only exists for debugging. It's a bit different between vanilla
" Vim and Neovim, but not if I disable it.
set writedelay=0

" `xtermcodes` is another one of those vanilla Vim options that relates to
" terminals. I don't want to touch this.

" ----------------------------------------------------------------------------
"
" Non-option options
"
" ----------------------------------------------------------------------------

" Enable syntax highlighting. This is enabled by default in Neovim but not
" vanilla Vim.
"
" The vanilla Vim docs claim that `enable` keeps your color settings and `on`
" does not, but it [seems like that might not actually be the case][0]. Neovim
" makes no such claim and seems to suggest that `syntax on` is equivalent to
" `syntax enable`.
"
" This also enables filetype detection, as if you'd run `:filetype on`.
"
" In Neovim, that runs `$VIMRUNTIME/filetype.lua`. Based on my reading of that
" script, the buffer and filename are passed to `vim.filetype.match()`, which
" uses the filename and contents to determine the filetype.
"
" Vanilla Vim's version, `$VIMRUNTIME/filetype.vim`, looks similar at a high
" level, but seems to vary on a lot of details.
"
" [0]: https://stackoverflow.com/a/33380495/804100
if has('syntax')
	syntax enable
endif

" Try to use the relatively-new (2023, I think?) `wildcharm` theme. Then try
" the slightly-older `lunaperche`, and then give up and use the default.
try
	colorscheme wildcharm
catch /^Vim\%((\a\+)\)\=:E185:/
	try
		colorscheme lunaperche
	catch /^Vim\%((\a\+)\)\=:E185:/
		colorscheme default
	endtry
endtry

" ----------------------------------------------------------------------------
"
" Plugins
"
" ----------------------------------------------------------------------------

" Install plugins with vim-plug.
"
" Because I sometimes use vanilla Vim, and not Neovim, I wanted something that
" works in both with limited sacrifice. I haven't done a detailed comparsion
" beyond that, but vim-plug seems good (and is maintained by junegunn, who
" also maintains fzf and Goyo).
"
" TODO: Catch a more specific error
try
  call plug#begin("$XDG_CONFIG_HOME/nvim/plugged")
catch
endtry

if exists(':Plug')
	" NERDTree file explorer
	" ======================

	Plug 'preservim/nerdtree'

	" When doing tree navigation (such as `NERDTree-J`), don't try to center
	" around the cursor. `NERDTreeHighlightCursorline` already brings enough
	" attention to the current spot, and this can help avoid some jumpiness.
	" (`NERDTreeAutoCenterThreshold` is unnecessary here, so I set it to a value
	" that seems reasonable in case I re-enable auto centering.)
	let NERDTreeAutoCenter = 0
	let NERDTreeAutoCenterThreshold = 3

	" Tell NERDTree to auto-detect whether it's running on a case-sensitive file
	" system. (It uses a simple heuristic that's probably correct.)
	let NERDTreeCaseSensitiveFS = 2

	" Sort nodes case-insensitively, and use natural sort.
	let NERDTreeCaseSensitiveSort = 0
	let NERDTreeNaturalSort = 1

	" Don't change the current working directory (but if you do, use `:tcd`
	" instead of `:cd`).
	let NERDTreeUseTCD = 1
	let NERDTreeChDirMode = 0

	" Enable `cursorline` in NERDTree buffers.
	let NERDTreeHighlightCursorline = 1

	" Prefer NERDTree to netrw, and disable netrw.
	let NERDTreeHijackNetrw = 1
	let g:loaded_netrw = 1
	let g:loaded_netrwPlugin = 1

	" Use `wildignore` instead of a special list for NERDTree.
	let NERDTreeIgnore = []
	let NERDTreeRespectWildIgnore = 1

	" Store NERDTree bookmarks in the state folder, or in `~/.vim` in vanilla
	" Vim.
	if has('nvim')
		let NERDTreeBookmarksFile = stdpath('state') . '/NERDTreeBookmarks'
	else
		silent! execute '!mkdir -p ' . expand('$HOME/.vim')
		let NERDTreeBookmarksFile = expand('$HOME/.vim/NERDTreeBookmarks')
	endif

	" Sort bookmarks case-insensitively.
	let NERDTreeBookmarksSort = 1

	" Show bookmarks in the UI.
	let NERDTreeMarkBookmarks = 1

	" Require double-click to open files and directories.
	let NERDTreeMouseMode = 1

	" Close NERDtree after opening a file or bookmark.
	let NERDTreeQuitOnOpen = 3

	" Hide bookmarks. `B` will show this later if you want.
	let NERDTreeShowBookmarks = 0

	" Show files, not just directories. `F` toggles this option.
	let NERDTreeShowFiles = 1

	" Don't show the number of lines in a file. `FL` toggles this option.
	let NERDTreeFileLines = 0

	" Show hidden files. `I` toggles this option.
	let NERDTreeShowHidden = 1

	" Don't show line numbers in the NERDTree window (e.g., `set nonumber`).
	let NERDTreeShowLineNumbers = 0

	" List directories first, then everything else.
	let NERDTreeSortOrder = ['\/$', '*']

	" Blank status line in NERDTree buffers.
	let NERDTreeStatusline = ' '

	" I don't like to leave NERDTree up for long (see `NERDTreeQuitOnOpen`), so
	" it's okay if it takes up a lot of the screen. I put it on the bottom for
	" that reason. If I had it up for longer (like a more traditional file
	" explorer), I'd do something else.
	let NERDTreeWinPos = 'bottom'
	let NERDTreeWinSize = 15

	" Keep the Bookmarks label, the "Press ? for help" text, and the "up a dir"
	" button.
	let NERDTreeMinimalUI = 0

	" Show a full menu for updating nodes.
	let NERDTreeMinimalMenu = 0

	" Collapse directories that only have one child.
	let NERDTreeCascadeSingleChildDir = 1
	let NERDTreeCascadeOpenSingleChildDir = 1

	" If a file is deleted, delete its associated buffer.
	let NERDTreeAutoDeleteBuffer = 1

	" Hide NERDTree buffer creation output.
	let NERDTreeCreatePrefix = 'silent'

	" `NERDTreeDirArrowCollapsible` and `NERDTreeDirArrowExpandable` vary based
	" on the OS and have reasonable defaults, so I don't set them.

	" `NERDTreeNodeDelimiter` is a setting I don't completely understand, but it
	" seems to relate to unusual characters in file names. Its default value is
	" a little complex, so I don't set it.

	" When opening a file, open it in the previous window that's in this tab.
	" When opening a directory, try to reuse any existing buffer.
	let NERDTreeCustomOpenArgs = {
				\'file': { 'where': 'p', 'reuse': 'currenttab', },
				\'dir': { 'reuse': 'all', },
				\}

	" Linting, formatting, LSP with ALE
	" =================================

	" Neovim's LSP tools are good, but they only work with LSPs. For example,
	" `shellcheck` is not supported.

	if has('nvim') || (has('job') && has('channel') && has('timers'))
		Plug 'dense-analysis/ale'

		" If I ever enable Airline...
		let g:airline#extensions#ale#enabled = 1

		" If an executable isn't found, no need to cache it. We can keep checking.
		" Slightly slower, but probably fine in practice.
		let g:ale_cache_executable_check_failures = 0

		" Don't change the sign column color.
		let g:ale_change_sign_column_color = 0

		" TODO: g:ale_close_preview_on_insert

		" No need to wrap commands that ALE runs.
		let g:ale_command_wrapper = ''

		" TODO: g:ale_completion_*

		" When moving to a line with problems, don't open the preview window
		" automatically.
		let g:ale_cursor_detail = 0

		" TODO: g:ale_default_navigation

		" Don't use a floating window for `:ALEDetail`.
		let g:ale_detail_to_floating_preview = 0

		" Automatically disable linters that have already been set up.
		let g:ale_disable_lsp = 'auto'

		" No need to show a truncated message when near a warning or error,
		" because Neovim's diagnostics cover that. Set a bunch of reasonable
		" default values in case I re-enable it.
		let g:ale_echo_cursor = 0
		let g:ale_echo_delay = 100
		let g:ale_echo_msg_error_str = 'Error'
		let g:ale_echo_msg_format = '%%s'
		let g:ale_echo_msg_info_str = 'Info'
		let g:ale_echo_msg_log_str = 'Log'
		let g:ale_echo_msg_warning_str = 'Warning'

		" Enable ALE, at least by default.
		let g:ale_enabled = 1

		" Has no effect when using Neovim's diagnostics (which I do). But if not,
		" like in Neovim, I don't want to exclude highlighting for any messages.
		" See `g:ale_set_highlights` and `g:ale_use_neovim_diagnostics_api`.
		let g:ale_exclude_highlights = []

		" Set up ALE fixers. Typically, I want to use the defaults, but
		" sometimes I want something custom. See `g:ale_linters`.
		let g:ale_fixers = {
					\'javascript': ['deno'],
					\'python': ['black'],
					\'typescript': ['deno'],
					\}

		" Don't auto-fix on save. However, my <Leader><Leader> shortcut does do
		" this; see my mappings elsewhere.
		let g:ale_fix_on_save = 0
		let g:ale_fix_on_save_ignore = {}

		" TODO: g:ale_floating_*

		" Save the history of commands that get run, but not their output. See
		" `g:ale_max_buffer_history_size`.
		let g:ale_history_enabled = 1
		let g:ale_history_log_output = 0

		" TODO: set options after and including `g:ale_hover_cursor`

		" Set up ALE linters. Typically, I want to use the defaults, but
		" sometimes I want something custom. See `g:ale_fixers`.
		let g:ale_linters = {
					\'javascript': ['deno'],
					\'python': ['pylint', 'mypy', 'pyright'],
					\'typescript': ['deno'],
					\}

		" Only save the last 10 commands.
		let g:ale_max_buffer_history_size = 10

		" Use the Neovim diagnostics API, if available.
		let g:ale_use_neovim_diagnostics_api = has('nvim-0.7')

		" Use the Neovim LSP API, if available.
		let g:ale_use_neovim_lsp_api = has('nvim-0.8')
	endif

	" Distraction-free writing with Goyo
	" ==================================

	Plug 'junegunn/goyo.vim', { 'on': ['Goyo', 'Goyo!'] }

	" Set Goyo's dimensions.
	let g:goyo_width = 80
	let g:goyo_height = '100%'

	" Hide line numbers in Goyo.
	let g:goyo_linenr = 0

	" Vimux, integrating tmux and vim
	" ================================

	Plug 'preservim/vimux'

	" Open tmux panes to the right (or maybe left?), not top or bottom. And make
	" them 30% wide.
	let g:VimuxOrientation = 'h'
	let g:VimuxHeight = '30%'

	" Use the closest pane.
	let g:VimuxUseNearest = 1

	" Clear the line with C-u before running a command.
	let g:VimuxResetSequence = 'C-u'

	" When prompting for a command, use this string.
	let g:VimuxPromptString = 'Vimux command: '

	" Use a tmux pane (not a window) for the runner.
	let g:VimuxRunnerType = 'pane'

	" Don't set a name for the runner.
	let g:VimuxRunnerName = 'vimuxout'

	" Don't do anything funny with the tmux command. Call `tmux`, don't pass
	" additional args, don't expand anything,
	let g:VimuxTmuxCommand = 'tmux'
	let g:VimuxOpenExtraArgs = ''
	let g:VimuxExpandCommand = 0

	" Don't close the runner when I quit Vim.
	let g:VimuxCloseOnExit = 0

	" Enable shell completion.
	let g:VimuxCommandShell = 1

	" Just use the default query for finding an existing runner.
	let g:VimuxRunnerQuery = {}

	" Fugitive, a Git helper
	" ======================

	Plug 'tpope/vim-fugitive', {
				\'on': [
				\'FugitiveFind',
				\'FugitiveStatusline',
				\'GBrowse',
				\'GDelete',
				\'GMove',
				\'GRemove',
				\'GRename',
				\'Gdiffsplit',
				\'Gedit',
				\'Ggrep',
				\'Git',
				\'Glgrep',
				\'Gread',
				\'Gvdiffsplit',
				\'Gwrite',
				\]
				\}

	" `:Git blame` should show commit hashes with different colors to make them
	" easier to differentiate.
	let g:fugitive_dynamic_colors = 1

	" Keep the maps in the status buffer. See `:help fugitive-maps`.
	let g:fugitive_no_maps = 0

	" Fuzzy finder with fzf
	" =====================

	if has('nvim') || v:version >= 800
		Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
		Plug 'junegunn/fzf.vim'

		" Start all fzf commands with Fzf (so `:Files` becomes `:FzfFiles`).
		let g:fzf_command_prefix = 'Fzf'

		" Prepare options to be set.
		let g:fzf_vim = {}

		" `:FzfBuffers`: jump to an existing window if one exists.
		let g:fzf_vim.buffers_jump = 1

		" The `:FzfCommands` command is poorly-documented, so I don't set
		" `g:fzf_vim.commands_expect`.

		" `git log` output used by `:FzfCommits`.
		let g:fzf_vim.commits_log_options = '--graph --color=always --format="%C(black)%C(bold)%cs %an %C(auto)%s"'

		" `:Fzf{Ag,Rg,RG}` should display "PATH:LINE:COL:LINE" all on one line.
		let g:fzf_vim.grep_multi_line = 0

		" TODO: g:fzf_vim.listproc (should it use quickfix or loclist?)

		" Show the preview window on the right, filling 60% of the window, with
		" sharp borders, no text wrapping, scrolled to the top by default, no
		" wrap-around scrolling, with scroll offset information, shown by default.
		" And if on a narrow window, use a vertical layout.
		let g:fzf_vim.preview_window = [
					\'right,60%,border-sharp,nowrap,nofollow,nocycle,info,nohidden,<40(bottom,50%)',
					\'ctrl-/'
					\]

		" I don't mess with ctags so I don't set `g:fzf_vim.tags_command`.
	endif

	" vim-fetch lets you do things like `vim file.txt:123`
	" ====================================================

	Plug 'wsdjeg/vim-fetch'

	" Auto-insert `end` or equivalent with endwise.vim
	" ================================================

	Plug 'tpope/vim-endwise', {
				\'for': [
				\'c',
				\'cpp',
				\'crystal',
				\'elixir',
				\'lua',
				\'objc',
				\'ruby',
				\'sh',
				\'vim',
				\'xdefaults',
				\'zsh',
				\]
				\}

	call plug#end()
endif

" Disable built-in plugins, for a small performance and security boost.
let g:loaded_2html_plugin = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logipat = 1
let g:loaded_rrhelper = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

" Neovim and vanilla Vim both support commenting/uncommenting with chords like
" `gcc`. We have to do a little more work to enable it in vanilla Vim, where a
" package was added in v9.1.0375.
if !has('nvim') && has('packages') && has('patch-9.1.0375')
	packadd comment
endif

" ----------------------------------------------------------------------------
"
" Autocmds
"
" ----------------------------------------------------------------------------

" Editing large files can be slow. If a file is over 1 megabyte (a somewhat
" arbitrary limit), change some features for performance:
"
" - Disable line wrapping, as it can be slow to calculate for long lines. If
"   wrapping is ever re-enabled, wrap less intelligently. (`nowrap` and
"   `nolinebreak`)
" - Disable as much folding as we can.
" - Disable swap and undo. (`noswapfile` and `undolevels`)
" - When writing, don't make any kind of copy. Just write the file, errors be
"   damned. (`nobackup`, `patchmode=`, `nowritebackup`)
"
" Some other features are automatically disabled. For example, `inccommand` is
" disabled if it takes longer than `redrawtime`.
"
" This is *heavily* modified from the [LargeFile plugin][0].
"
" Vim isn't usually the best choice for editing large files, but let's try our
" best.
"
" [0]: https://www.vim.org/scripts/script.php?script_id=1506
function! s:HandleLargeFiles() abort
	if getfsize(expand('%')) > 1000000
		setlocal nowrap
		setlocal nolinebreak

		setlocal foldmethod=manual
		setlocal nofoldenable

		setlocal noswapfile
		setlocal undolevels=-1

		setlocal nobackup
		setlocal patchmode=
		setlocal nowritebackup
	endif
endfunction
autocmd BufReadPre * call s:HandleLargeFiles()

" If creating new files, insert a template in some cases. For example, editing
" an empty HTML file should insert a basic template.
function! s:InsertTemplate(filetype) abort
  let template_path = $XDG_CONFIG_HOME . '/evanhahn-snippets/' . a:filetype
  try
    0read `=template_path`
  catch /E484:/
    " Snippet file doesn't exist
  endtry
endfunction
autocmd BufNewFile *.c call s:InsertTemplate('c')
autocmd BufNewFile *.go call s:InsertTemplate('go')
autocmd BufNewFile *.html call s:InsertTemplate('html')

" ----------------------------------------------------------------------------
"
" Mappings
"
" ----------------------------------------------------------------------------

" Change the leader to <Space>. It makes a lot of things faster to type—after
" all, it's the largest key on most keyboards!
let mapleader = "\<Space>"

" Double-tap leader to (1) disable search highlights (2) auto-format
" (3) write the file if changed, creating intermediate directories. This is
" the default way I save files most of the time (though I use others too,
" like `:wa` and `:x`).
function! EvanHahnSave() abort
	nohlsearch
	ALEFix
	update ++p
endfunc
nnoremap <silent> <Leader><Leader> :call EvanHahnSave()<CR>

" Make Y linewise. This is the default in Neovim, and makes more sense (to
" me) because it's consistent with D.
nnoremap Y y$

" Swap `0` and `^` based on which I find easier to type.
nnoremap 0 ^
nnoremap ^ 0

" `j` and `k` are typically aliases for `gj` and `gk`, which move by *display*
" lines not by *source* lines. But if I'm making a bigger jump, use source
" lines.
nnoremap <expr> j v:count ? (v:count > 2 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 2 ? "m'" . v:count : '') . 'k' : 'gk'

" Go forward and back in the quickfix list. (Note that this affects how arrow
" keys work with `keymode=startsel`.)
nnoremap <S-Left> :cprev<CR>
nnoremap <S-Right> :cnext<CR>

" Disable some chords I simply never use, and don't want to run by accident.
nnoremap ZQ <nop>
nnoremap ZZ <nop>

" Neovim maps `Q` to "repeat the last recorded register", which is actually
" useful. Vanilla Vim starts Ex mode, which I don't want, so I remap it to an
" error.
if !has('nvim')
	nnoremap Q :echoerr "Evan Hahn hasn't ported Neovim's Q to vanilla Vim, so Q is disabled."<CR>
endif

" Simple plugin mappings.
nnoremap <Leader>k :NERDTreeToggle<CR>
nnoremap - :NERDTreeFind<CR>
nnoremap <silent> <Left> :ALEPrevious<CR>
nnoremap <silent> <Right> :ALENext<CR>
nnoremap <Leader>t :VimuxRunLastCommand<CR>

" A helper for running `:Ggrep` on the current word.
" TODO: This could be cleaned up a bit.
function! EscapeForQuery(text) abort
  " taken from <https://github.com/elentok/dotfiles/blob/36a9cf07394cd4ac70c40817dea432c22a885976/vim/functions.vim#L160-L164>
  let l:text = substitute(a:text, '\v(\[|\]|\$|\^)', '\\\1', 'g')
  let l:text = substitute(l:text, "'", "''", 'g')
  return text
endfunc
nnoremap <Leader>gg :Ggrep <C-R>=EscapeForQuery(expand('<cword>'))<CR><CR><CR>
