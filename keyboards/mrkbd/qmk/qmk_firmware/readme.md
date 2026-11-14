# mrkbd

* Keyboard Maintainer: [foostan](https://github.com/foostan/) [@foostan](https://twitter.com/foostan)

One-piece, 53-electrical-position, low-profile keyboard built around the
STM32G0B1KBU6. The current PCB/plate populates 50 of those positions; three
(matrix `[1,13]`, `[2,13]`, `[3,12]`) are wired but left as DNP routing stubs
and are intentionally excluded from this `LAYOUT`. See
`src/github.com/foostan/mrkbd/design.md` for the authoritative hardware
design policy.

Flash example for this keyboard:

```sh
qmk flash -kb mrkbd -km default
```

See the [build environment setup](https://docs.qmk.fm/#/getting_started_build_tools) and the [make instructions](https://docs.qmk.fm/#/getting_started_make_guide) for more information. Brand new to QMK? Start with our [Complete Newbs Guide](https://docs.qmk.fm/#/newbs).

## Bootloader

Entering the bootloader requires the on-board `BOOT1` button (pulls
`PA14/BOOT0` high) held while `NRST1` is pressed/released, or QMK bootmagic
(hold the top-left key while plugging in USB). There is no SWD header in the
baseline design, so DFU-over-USB is the only production recovery path.
