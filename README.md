Eliza's Dotfiles
================

Eliza Weisman's personal dotfiles, managed using Thoughtbot's [rcm](https://github.com/thoughtbot/rcm) tool.

My configurations are biased towards Mac OS X and Atom; there's minimal support for other OSes and tools currently. Lots of support for Rust and Scala, my languages of choice.

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
