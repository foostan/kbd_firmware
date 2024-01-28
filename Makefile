.PHONY: git-submodule, qmk

git-submodule:
	git submodule update --remote
	git submodule update --init --recursive

qmk:
	git subtree pull --prefix firmwares/qmk/qmk_firmware https://github.com/qmk/qmk_firmware.git master --squash
