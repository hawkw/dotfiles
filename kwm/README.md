kwm
===

Configuration for the [kwm](https://github.com/koekeishiya/kwm) tiling window manager.

Commands
--------

The `Brewfile` distributed with my dotfiles should install `kwm` for you. If it's not installed, you can install it with:
```
$ brew install koekeishiya/kwm/kwm
```

You can start `kwm` with:
```
$ brew services start kwm
```
and stop it with:
```
$ brew services stop kwm
```
or restart it with:
```
$ brew services restart kwm
```

To reload the kwm configs, use:
```
$ kwmc config reload
```

Keybindings
-----------

Files
-----

```
.kwm
├── README.md       # this file
├── binds           # kwm keybindings
├── bsp-layout      # kwm binary space partitioning layout config
├── kwmrc           # kwm runtime config file (includes `binds`, `rules`, and `bsp-layout`)
├── rules           # rules for configuring kwm for specific applications
└── scripts
    └── screencapture.sh
