Initially i created this script to *properly* spawn
**i3wm** in a **Xephyr** window on a i3wm host session.
This boils down to setting the environment
variable I3SOCK to a path that doesn't conflict
with the current session.

[xwmplayd2-2023-09-19_21.28.06.webm](https://github.com/budRich/xwmplay/assets/2143465/7e5d712b-0797-4060-b7f8-126bee59e3df)


While messing around with this I noticed that it
was possible to tile the Xephyr window, but it
would have the same initial resolution (equal to
initial windowsize), and when tiled, this
sometimes got messed up. It is possible to update
the resolution by simply executing `xrandr` in
the nested session. I searched and found [xeventbind],
which can watch for changes in screen resolution and
execute a command when that happens, so I added that
to the script as well.

Another thing I noticed was that if i didn't
`Ctrl-c` terminate the xephyr process it was left
in a limbo state, making it confusing to start
new sessions on the same display. This happened
if i either killed the xephyr window or if i did
`i3-msg exit`. I solved it by starting `xephyr`
and `xeventbind` in the background from the
script and making the windowmanager command
blocking, and last in the script do a `kill -P
$$`, which do kill all child processes of the
script.

I have tested the script with i3wm, and `icewm`
and some random other GUI programs, it
should "*work*" with other windowmanagers, but
they may or may not have similar IPC quirks as
i3.

Also, it is probably a good idea to use a separate
config file for the nested wm. To avoid clashes
with keybindings and other weirdness.

`xwmplay -- i3 -c ~/.config/my-special-xephyr-config`

The Xephyr window will have the *instance*
name: **Xephyr**, so it is possible to control it
with f.i. window rules (`for_window` in i3wm).

[xeventbind]: https://github.com/ritave/xeventbind/


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

[xwmplay AUR package]: https://aur.archlinux.org/packages/xwmplay

## usage

```
xwmplay [OPTIONS] -- COMMAND
-d, --display           DISPLAY | set X display for COMMAND (defaults to 2) 
-h, --help                      | print help and exit  
-v, --version                   | print version info and exit  
-w, --wallpaper-command COMMAND | command to set wallpaper
```

## copyright

Copyright (c) 2023, budRich of budlabs  
SPDX-License-Identifier: 0BSD
