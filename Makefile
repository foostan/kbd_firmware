.PHONY: git-submodule, qmk-clean, qmk-init-%, qmk-compile-%, qmk-flash-%, qmk-clean-%

git-submodule:
	git submodule update --remote
	git submodule update --init --recursive

qmk-clean:
	rm -rf firmwares/qmk/qmk_firmware/keyboards/tmp
	cd firmwares/qmk/qmk_firmware; qmk clean

qmk-init-%:
	$(eval KBD := ${@:qmk-init-%=%})
	rm -rf firmwares/qmk/qmk_firmware/keyboards/tmp/${KBD}
	mkdir -p firmwares/qmk/qmk_firmware/keyboards/tmp/${KBD}
	cp -r keyboards/crkbd/qmk/qmk_firmware/ firmwares/qmk/qmk_firmware/keyboards/tmp/${KBD}

qmk-compile-%:
	$(eval KBD := ${@:qmk-compile-%=%})
	cd firmwares/qmk/qmk_firmware; qmk compile -kb tmp/${KBD} -km default

qmk-flash-%:
	$(eval KBD := ${@:qmk-flash-%=%})
	cd firmwares/qmk/qmk_firmware; qmk flash -kb tmp/${KBD} -km default

qmk-clean-%:
	$(eval KBD := ${@:qmk-flash-%=%})
	rm -rf firmwares/qmk/qmk_firmware/keyboards/tmp/${KBD}
