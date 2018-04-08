Eliza's Dotfiles
================

Eliza Weisman's personal dotfiles, managed using Thoughtbot's [`rcm`](https://github.com/thoughtbot/rcm) tool.

![screenshot](/img/screenshot_01.png)

#### Note on Support
My configurations are biased towards macOS, [Atom](https://atom.io), and [Hyper](https://hyper.is); there's minimal support for other OSes and tools currently. Lots of support for Rust, Haskell, and Scala, my languages of choice. Most packages are installed using [Homebrew](https://brew.sh), so if your system uses another package manager, you may not get everything you need to make all my configurations work right off the bat.

#### Note on Fonts
My terminals and text editors are typeset using [Iosevka](https://be5invis.github.io/Iosevka/), a slender monospace sans-serif and slab-serif typeface designed for code. If you install using the `Brewfile` in this repository, Iosevka (and its [Nerd Fonts](http://nerdfonts.com) patched version) will be installed automagically, along with a number of other open-source fonts that I like.

 While you can, of course, change the default editor and terminal fonts to whatever font you prefer, do note that my `zsh` prompt is currently configured to use a [Nerd Fonts](http://nerdfonts.com) patched font. If you use a non-patched font, some glyphs may not show up as expected.


Install
-------

Clone this repo:

    $ git clone git://github.com/hawkw/dotfiles.git ~/dotfiles

Install [rcm](https://github.com/thoughtbot/rcm):

    $ brew tap thoughtbot/formulae
    $ brew install rcm

Install the dotfiles:

    $ env RCRC=$HOME/dotfiles/rcrc rcup

After the initial installation, you can run `rcup` without the one-time variable
`RCRC` being set (`rcup` will symlink the repo's `rcrc` to `~/.rcrc` for future
runs of `rcup`). [See
example](https://github.com/thoughtbot/dotfiles/blob/master/rcrc).

This command will create symlinks for config files in your home directory.
Setting the `RCRC` environment variable tells `rcup` to use standard
configuration options:

* Exclude the `README.md` and `LICENSE` files, which are part of
  the `dotfiles` repository but do not need to be symlinked in.
* Give precedence to personal overrides which by default are placed in
  `~/dotfiles-local`

You can safely run `rcup` multiple times to update:

    rcup

You should run `rcup` after pulling a new version of the repository to symlink
any new files in the repository.

Contents
--------

Coming soon!
