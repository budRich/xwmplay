
## installation

This is just a small simple bash script, but it
needs to be "built" before installation, and that
is done with `GNU make` . It is possible to customize
the shbang in the generated script, like this:

`make SHBANG='#!/usr/bin/env bash'`

There is some cool `gawk` code in the makefile, so
`gawk` is a build dependency. 

```
$ make
# make install
```

Runtime dependencies is `Xephyr` . Optionally if
`xrandr` and `xeventbind` is installed auto update
of screenresolution is a thing.

### btw

There is also the [xwmplay AUR package].

[xwmplay AUR package]: https://aur.archlinux.org/xwmplay
