# The Fat Controller

[![Crates.io](https://img.shields.io/crates/v/tfc)](https://crates.io/crates/tfc)
[![Docs.rs](https://docs.rs/tfc/badge.svg)](https://docs.rs/tfc)
![License](https://img.shields.io/crates/l/tfc)

TFC is a library for simulating mouse and keyboard events. This library was
built for use by [TFC-server](https://crates.io/crates/tfc-server), a server
that allows for remote control of a PC via a mobile app.

## Features

- Mouse clicks
- Mouse motion (relative and absolute)
- Mouse scrolling (smooth scrolling where supported)
- Key presses
- Translating Unicode characters to key presses
- Typing arbitrary Unicode strings
- Getting the mouse position
- Getting the size of the screen

## Platforms

- Linux - With X11
- Linux - Without X11
- macOS
- Windows

## Linux

There are two implementations for Linux, one that uses X11, and one that depends
only on the Linux kernel. The implementation that doesn't use X11 is missing
some features. It is intended for Wayland but Wayland is a bit more locked down
compared to X11, hence the missing features.

Before using the X11 implementation, the X11, XTest and xkbcommon development
libraries need to be installed. Using `apt`, the following snippet can be used.

```shell
sudo apt install libx11-dev libxtst-dev libxkbcommon-dev
```

The non-X11 implementation uses `/dev/uinput`. Before this can be used,
permissions need to be granted. The following snippet can be used.

```shell
sudo sh -c 'echo -e "KERNEL==\"uinput\", MODE=\"0666\"" >> /etc/udev/rules.d/50-uinput.rules'
```

## Usage

Add the following to your `Cargo.toml`:

```toml
[dependencies]
tfc = "0.5"
```

## Example

```rust
use tfc::{Context, Error, traits::*};
use std::{f64::consts::PI, thread, time::Duration};

fn main() -> Result<(), Error> {
    let mut ctx = Context::new()?;
    let radius = 100.0;
    let center = ctx.cursor_location()?;
    let center = (center.0 as f64 - radius, center.1 as f64);
    let steps = 200;
    let revolutions = 3;
    let delay = Duration::from_millis(10);

    for step in 0..steps * revolutions {
        thread::sleep(delay);
        let angle = step as f64 * 2.0 * PI / steps as f64;
        let x = (center.0 + radius * angle.cos()).round() as i32;
        let y = (center.1 + radius * angle.sin()).round() as i32;
        ctx.mouse_move_abs(x, y)?;
    }

    Ok(())
}
```
