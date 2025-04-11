" ----------------------------------------------------------------------------
"
" Start by setting options that affect reading of Vim startup files.
"
" ----------------------------------------------------------------------------

" Deviate from Vi compatibility. This does nothing in Neovim, which is "always
" 'nocompatible'". In vanilla Vim, this sets a bunch of options, and its docs
" recommend putting this "at the very start" of your vimrc.
set nocompatible

" My config files use UTF-8. This only affects vanilla Vim because Neovim
" always uses UTF-8. It's probably fine to set this later, but I set it at the
" top just in case.
set encoding=utf-8

" ----------------------------------------------------------------------------
"
" Options, in alphabetical order.
"
" ----------------------------------------------------------------------------

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
" one and tweaks formatting. See `cindent`, `smartindent`, and several other
" indentation options.
set autoindent

" Update the file if it's changed outside of Vim.
set autoread

" I only want files to save when I run `:w` or equivalent. `autowrite` and
" `autowriteall` aren't what I want.
set noautowrite
set noautowriteall

" `background` should use my system theme, which is set by my primitive
" `theme` command. If not found, it should use a dark theme.
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
	silent! execute '!mkdir -p ' . expand('$MYVIMDIR/backup/')
	let &backupdir = expand('$MYVIMDIR/backup//')
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
" - Show the value of `showbreak` at the beginning of the shift.
" - Add indent for lines that match a bulleted or numbered list. See
"   `formatlistpat`.
if exists('&breakindent')
	set breakindent
	set breakindentopt=min:40,shift:4,sbr,list:-1
endif

" See `hidden`.
set bufhidden=

" When changing the case of letters, (1) use Vim's internal case modifier, not
" the system ones (2) always treat ASCII characters like English, which seems
" to only affect Turkish, according to the Vim docs.
set casemap=internal,keepascii

" `:cd` and friends should work like in Unix and go `$HOME`.
set cdhome

" Press this key in Command mode to open the command line window. (You can
" also open this with `q:`).
set cedit=<C-F>

" `charconvert` doesn't seem used very often. It is "not used when the
" internal iconv() function is supported and is able to do the conversion",
" and "conversion between 'latin1', 'unicode', 'ucs-2', 'ucs-4' and 'utf-8' is
" done internally".
"
" I've never run into this, so I just set it to the empty string, the default.
set charconvert=

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
set colorcolumn=+0

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

set complete=t,.,w,b,u

set completeopt=menu,preview

" Don't let me quit without saving.
set confirm

" Vanilla Vim (not not Neovim) has encryption support, which is a bit wonky.
" The `cryptmethod` option configures the encryption method, and it's
" sometimes auto-detected. I'll let Vim decide what to do here. See also:
" `key`.

" Don't bind cursors. This gets overridden in diff mode (`nvim -d`). See
" `scrollbind`.
set nocursorbind

" Don't show a highlight at the current column...
set nocursorcolumn

" ...but do show one at the current line.
set cursorline

" Show the cursorline on the line (highlighting multiple screen lines if the
" line is wrapped), and highlight line numbers too.
set cursorlineopt=both

" Disable any debug messages. (This is the default.)
set debug=

" Different `ftplugin`s set different values for `define`. For example, C's is
" `^\s*#\s*define`. I admit I'm not super clear on how this used, but a
" default empty value seems reasonable.
set define=

" Hit backspace to delete combining characters piece by piece, not all at
" once. Irrelevant for ASCII, but some Unicode glyphs may be made up of
" combining characters, such as 👩🏾‍🌾. (The naming of this seems flipped
" to me. Shouldn't `delcombine` combine characters and `nodelcombine` separate
" them?)
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
	silent! execute '!mkdir -p ' . expand('$MYVIMDIR/swap/')
	let &directory = expand('$MYVIMDIR/swap//')
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

" Ring the bell for error messages. See `belloff`.
set errorbells

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
set fillchars=eob:\ ,lastline:.
if !has('nvim')
	set fillchars+=vert:│
endif

" I don't want to add an <EOL> to the end of a file if it's missing. I don't
" want to change this value.
set nofixendofline

set nofoldenable

" Delete comments when joining commented lines. Lifted from [vim-sensible][0].
"
" TODO: Explain this in more detail and consider changing it.
" [0]: https://github.com/tpope/vim-sensible/blob/0ce2d843d6f588bb0c8c7eec6449171615dc56d9/plugin/sensible.vim#L87-L90
set formatoptions=tcqn
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
"
" I may start setting these if I ever use GUI Vim.

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
" them as their defaults.

" `hl` is an option exclusive to vanilla Vim, and was removed in Neovim for a
" good reason: you shouldn't mess with built-in highlight groups. I don't
" touch this option and let vanilla Vim pick its default.

" Highlight all search matches, not just the current one.
if has('extra_search')
	set hlsearch
endif

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
if exists('&inccommand')
	set inccommand=nosplit
endif

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

" Don't make Insert mode the default. No-op in Neovim, where the option
" doesn't exist.
set noinsertmode

" Insert just one space after a join.
set nojoinspaces

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
if exists('&langremap')
	set nolangremap
endif

" Always show the status line, which has a bunch of useful information. See
" `statusline`.
set laststatus=2

" Wrap long lines at `breakat`, not (just) the last character that fits on the
" screen. This makes line breaks easier to read, especially with prose.
set linebreak

" In terminal Vim, `lines` is set by the terminal, so I shouldn't set it. In
" GUI Vim, which I don't use, I'll trust whatever default they give. See
" `columns`.

" Don't show invisible characters by default (though I often turn this on
" manually). See `listchars`.
set nolist

" When `list` is enabled (or with the `:list` command), show tabs, EOLs,
" trailing white space, and invisible non-breaking space characters.
set listchars=tab:▸\ ,eol:¬,trail:·,nbsp:□

" `luadll`, which is exclusive to vanilla Vim, should come from the build. I
" don't want to set it.

" I disable `showmatch`, but if I didn't, I'd want the jump to be brief.
set matchtime=5

" "The maximum number of combining characters supported for displaying." This
" Unicode-related option is exclusive to vanilla Vim, where it stops combining
" code points into a single glyph after awhile. In Neovim, this is calculated
" with bytes, and is "guaranteed" to be compatible with vanilla Vim setting
" this to 6.
set maxcombine=6

" When a message is output, prompt the user to press Enter. Also, save a bunch
" of history, which you can see with `:messages`.
if exists('&messagesopt')
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
set mkspellmem=900000,3000,800

" I never use these. Better to disable them and some of their options.
set nomodeline
set nomodelineexpr
set modelines=0

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
set nomousemoveevent

" When using the scroll wheel, scroll as slowly as possible.
"
" Horizontal scrolling only works if `nowrap` is set, and doesn't seem
" supported in terminal Neovim based on the docs. But why not set it?
if exists('&mousescroll')
	set mousescroll=ver:1,hor:1
endif

" How quickly do you need to click twice for it to register as a double-click?
set mousetime=400

" CTRL-A and CTRL-X add and subtract from numbers.
"
" - `hex` adds support for hexadecimal numbers like `0x45`.
" - `bin` adds support for binary numbers like `0b1000101`.
" - `blank` ignores leading dashes based on preceding whitespace. The docs at
"   `:help nrformats` have a good example of how this works.
set nrformats=hex,bin,blank

" Show line numbers. Because I've also enabled `relativenumber`, enabling this
" only does one thing: show the current line number on the cursorline.
" Everything else is handled by `relativenumber`.
" `:help number_relativenumber` for more.
set number

" The line number column should be as small as possible.
set numberwidth=1

set omnifunc=syntaxcomplete#Complete

" I don't want to save old versions of files. See `backup` and `writebackup`.
set patchmode=

" `perldll`, which is exclusive to vanilla Vim, should come from the build. I
" don't want to set it.

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

" I don't want to debug the way redrawing works, so I leave this option empty.
if exists('&redrawdebug')
	set redrawdebug=
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
" Always report the number of lines changed.
set report=0


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
" CTRL-U and CTRL-D should scroll just a little.
set scroll=10

" Save several lines in terminal buffers. I don't use Neovim's terminal much,
" so I don't need this to be very big.
if exists('&scrollback')
	set scrollback=1000
endif

" Don't bind scrolling. This gets overridden in diff mode (`nvim -d`). See
" `cursorbind`.
set noscrollbind

" This option is exclusive to vanilla Vim + GUI + Windows. In that case, I'd
" want scrolling to affect where the mouse cursor is, not the current window.
" ("Systems other than MS-Windows always behave like this option is on.")
if exists('&scrollfocus')
	set scrollfocus
endif

" Keep 4 lines above and below the cursor when scrolling. See `sidescrolloff`
" for the horizontal version.
set scrolloff=4

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
" - a list of previously edited files (`'`)
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


" When indenting, round to a multiple of `shiftwidth`.
set shiftround

set shiftwidth=2

" Don't assume filenames are 8 characters with a 3-character extension. I
" don't use systems like this. (This option is only in vanilla Vim.)
if exists('&shortname')
	set noshortname
end

" When a long line is wrapped, show this at the indentation. See
" `breakindent`.
set showbreak=---

" TODO: explain this
set showcmd

" TODO: showcmdloc

" When `showmatch` is enabled, inserting a bracket (like `{`) will briefly
" jump to the matching one if it exists. I don't want this, especially because
" it's already highlighted, so I disable it. See `matchtime`.
set noshowmatch

set sidescroll=1

" The horizontal version of `scrolloff`.
set sidescrolloff=15

set smartcase

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
		silent! execute '!mkdir -p ' . expand('$MYVIMDIR')
		let &spellfile = expand('$MYVIMDIR/spellfile.') . &encoding . '.add'
	endif
	set spelllang=en_us
	set spelloptions=camel
	set spellsuggest=best,7
	if has('reltime')
		set spellsuggest+=timeout:3000
	endif
endif

" New splits should go below the current one.
set splitbelow

" When splitting, don't move the cursor.
set splitkeep=cursor

" New vertical splits should go to the right of the current one.
set splitright

set statusline=\ %f\ %*%<\ %m\ %=%l:%c/%L\ \ %p%%\ %r

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

" Don't do syntax highlighting for long lines. I notice this most often when
" I'm opening a minified JavaScript file.
set synmaxcol=500

" TODO: Explain this (and maybe change it)
set tabstop=2

" `tcldll`, which is exclusive to vanilla Vim, should come from the build. I
" don't want to set it.

" The `termguicolors` option enables rich colors (24-bit RGB) in the terminal,
" and uses GUI highlight groups instead of terminal highlight groups. I don't
" set this option because (1) I use a default color scheme which works fine in
" the terminal, so I don't need it (2) Neovim will set this automatically for
" me (3) I have a weak understanding of terminal colors so I don't want to
" mess anything up.

" When pasting, ignore various control characters. Only tab should be
" supported.
if exists('&termpastefilter')
	set termpastefilter=BS,FF,ESC,DEL,C0,C1
endif

" Vsync, but for Neovim.
if exists('&termsync')
	set termsync
endif

" `textwidth` is a buffer option, so I don't set it here.

" The tilde command (`~`) really should behave like an operator, but I'm so
" used to how it works that I keep it at the default: off.
set notildeop

" I don't care to set the window title.
if !has('gui_running')
  set notitle
endif

set undodir^=~/.cache/nvim/undo//

" Save undo history in `undodir`.
set undofile

" Let me undo up to 100 changes.
set undolevels=100

" Write the swap file after typing this many characters. Because I save often
" and `updatetime` is reasonably low, it should be fine to set this to a
" fairly large number. See `swapfile`.
set updatecount=65535

" Update the swap file after this amount of idle time. Also affects the
" `CursorHold` autocmd. See `updatecount` and `swapfile`.
set updatetime=1000

" TODO: varsofttabstop

" Tabs should be rendered as 4 spaces, at least by default.
set vartabstop=4

" Disable tracing and verbosity. Neovim and vanilla Vim behave differently
" here, but `verbose=0` should work the same on both. I might want to set
" these if I'm debugging something.
set verbose=0
set verbosefile=

" Where should I store `:mkview` files? I don't really use this option
" In Neovim, store `:mkview` files in the state folder. In vanilla Vim, use a
" folder in `~/.vim`. I don't use this feature much, but I set it anyway.
if has('nvim')
	let &viewdir = stdpath('state') . '/view//'
else
	silent! execute '!mkdir -p ' . expand('$MYVIMDIR/view/')
	let &viewdir = expand('$MYVIMDIR/view//')
endif

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
set wildignore+=__pycache__

set wildignorecase

set wildmenu

set wildmode=full

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
	endtry
endtry

" ----------------------------------------------------------------------------
"
" Plugins
"
" ----------------------------------------------------------------------------

" start vim-plug

try
  call plug#begin("$XDG_CONFIG_HOME/nvim/plugged")
catch
endtry

" plugins

let s:can_install_fzf = 0
let s:can_install_ale = 0

if exists(':Plug')
  let s:can_install_fzf = has('nvim') || v:version >= 800
  let s:can_install_ale = has('nvim') || (has('timers') && exists('*job_start') && exists('*ch_close_in'))

  " libraries used by other plugins
  Plug 'tpope/vim-repeat'

  " sensible vim defaults
  Plug 'tpope/vim-sensible'

  " languages
  Plug 'leafgarland/typescript-vim'
  Plug 'elixir-editors/vim-elixir'
  Plug 'gleam-lang/gleam.vim'

  " file finder
  Plug 'tpope/vim-vinegar'
  Plug 'scrooloose/nerdtree'

  " distraction-free writing
  Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

  " autocomment
  Plug 'tomtom/tcomment_vim', { 'on': ['TComment', 'TCommentAs', 'TCommentBlock', 'TCommentInline', 'TCommentMaybeInline', 'TCommentRight'] }

  " play with external tools
  Plug 'benmills/vimux'
  Plug 'tpope/vim-fugitive', { 'on': ['Git', 'Gedit', 'Gdiffsplit', 'Gvdiffsplit', 'Gread', 'Gwrite', 'Ggrep', 'Glgrep', 'GMove', 'GRename', 'GDelete', 'GRemove', 'GBrowse', 'FugitiveStatusline'] }
  if s:can_install_fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
  endif
  if s:can_install_ale
    Plug 'w0rp/ale'
  endif

  " 'Match 4 of 20' when searching
  Plug 'henrik/vim-indexed-search'

  " lets you do things like `vim file.txt:123`
  Plug 'kopischke/vim-fetch'

  " auto-insert `end` or equivalent
  Plug 'tpope/vim-endwise', { 'for': ['lua', 'elixir', 'ruby', 'crystal', 'sh', 'zsh', 'vim', 'c', 'cpp', 'objc', 'xdefaults'] }

  call plug#end()
endif

" disable built-in plugins

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

autocmd BufReadPost * if line2byte(line("$")) > 1048576 | syntax clear | set nowrap | endif

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

" Double-tap leader to (1) disable search highlights (2) write the file if
" changed, creating intermediate directories. This is the default way I save
" files most of the time (though I use others too, like `:wa` and `:x`).
nnoremap <Leader><Leader> :nohlsearch<CR>:update ++p<CR>

" Disable some chords I simply never use, and don't want to run by accident.
nnoremap K <nop>
nnoremap ZQ <nop>
nnoremap ZZ <nop>

" Neovim maps `Q` to "repeat the last recorded register", which is actually
" useful. Vanilla Vim starts Ex mode, which I don't want, so I remap it to an
" error.
if !has('nvim')
	nnoremap Q :echoerr "Evan Hahn hasn't ported Neovim's Q to vanilla Vim, so Q is disabled."<CR>
endif
