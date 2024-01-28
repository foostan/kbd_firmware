.PHONY: pull-qmk-firmware
pull-qmk-firmware:
	git subtree pull --prefix qmk/qmk_firmware https://github.com/qmk/qmk_firmware.git master --squash
