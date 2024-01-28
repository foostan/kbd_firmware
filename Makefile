.PHONY: qmk
qmk:
	git subtree pull --prefix firmwares/qmk/qmk_firmware https://github.com/qmk/qmk_firmware.git master --squash
