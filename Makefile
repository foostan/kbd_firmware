.PHONY: git-submodule, qmk-clean, qmk-init, qmk-compile, qmk-flash

KB := crkbd
KR := rev1
KM := default

git-submodule:
	git submodule update --remote
	git submodule update --init --recursive

qmk-clean:
	rm -rf firmwares/qmk/qmk_firmware/keyboards/tmp
	cd firmwares/qmk/qmk_firmware; qmk clean

qmk-init:
	$(eval KB := ${kb})
	$(eval KR := ${kr})
	$(eval KM := ${km})
	rm -f firmwares/qmk/qmk_firmware/keyboards/tmp/${KB}
	mkdir -p firmwares/qmk/qmk_firmware/keyboards/tmp
	ln -s $(shell pwd)/keyboards/${KB}/qmk/qmk_firmware firmwares/qmk/qmk_firmware/keyboards/tmp/${KB}

qmk-compile:
	$(eval KB := ${kb})
	$(eval KR := ${kr})
	$(eval KM := ${km})
	cd firmwares/qmk/qmk_firmware; qmk compile -kb tmp/${KB}/${KR} -km ${KM}

qmk-flash:
	$(eval KB := ${kb})
	$(eval KR := ${kr})
	$(eval KM := ${km})
	cd firmwares/qmk/qmk_firmware; qmk flash -kb tmp/${KB}/${KR} -km ${KM}
