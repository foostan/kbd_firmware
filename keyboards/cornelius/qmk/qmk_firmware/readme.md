# cornelius

![cornelius](https://i.imgur.com/kGoUGZgl.jpg)

Gasket mounted 40% column staggered keyboard manufactured by Yushakobo

* Keyboard Maintainer: [foostan](https://github.com/foostan/)
* Hardware Supported: Cornelius PCBs
* Hardware Availability: http://github.com/foostan

Make example for this keyboard (after setting up your build environment):

```sh
qmk compile -kb cornelius/rev1 -km default
```

Flashing example for this keyboard:

```sh
qmk flash -kb cornelius/rev1 -km default
```

## Bootloader

The board reset into bootloader mode via either the reset button (on the back of the PCB) or a configured `QK_BOOT` shortcut (which may vary depending on when the PCB was flashed).

Additionally, if you hold down the "ESC" buttons when plugging in the keyboard (per the default QWERTY layout), this will jump to the bootloader and reset the EEPROM (persistent storage).

See the [build environment setup](https://docs.qmk.fm/#/getting_started_build_tools) and the [make instructions](https://docs.qmk.fm/#/getting_started_make_guide) for more information. Brand new to QMK? Start with our [Complete Newbs Guide](https://docs.qmk.fm/#/newbs).
