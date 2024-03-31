# KBD firmware

## How to build
Get src of `qmk/qmk_firmware` and `vial-kb/vial-qmk` first
```sh
make git-submodule
```

### VIA

```sh
make qmk-clean
kb=crkbd make qmk-init
kb=crkbd kr=rev4/standard km=via make qmk-compile
```
A built data will be stored on `keyboards/crkbd/qmk/qmk_firmware/.build`\
Please change `kb`, `kr` and `km` when build other.

### Vial
```sh
make vial-qmk-clean
kb=crkbd make vial-qmk-init
kb=crkbd kr=rev4/standard km=vial make vial-qmk-compile
```
A built data will be stored on `keyboards/crkbd/vial-kb/vial-qmk/.build`\
Please change `kb`, `kr` and `km` when build other.

### All clean and build
```sh
make git-submodule
```
