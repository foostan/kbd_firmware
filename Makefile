.PHONY: git-submodule, qmk-clean, qmk-init, qmk-compile, qmk-flash, qmk-init-all, qmk-compile-all

KB := crkbd
KR := rev1
KM := default

git-submodule:
	git submodule update --remote
	git submodule update --init --recursive

qmk-clean:
	rm -rf src/qmk/qmk_firmware/keyboards/tmp
	cd src/qmk/qmk_firmware; qmk clean

qmk-init:
	$(eval KB := ${kb})
	rm -f src/qmk/qmk_firmware/keyboards/tmp/${KB}
	mkdir -p src/qmk/qmk_firmware/keyboards/tmp
	ln -s $(shell pwd)/keyboards/${KB}/qmk/qmk_firmware src/qmk/qmk_firmware/keyboards/tmp/${KB}

qmk-compile:
	$(eval KB := ${kb})
	$(eval KR := ${kr})
	$(eval KM := ${km})
	$(eval FILE := $(shell echo "${kb}_${kr}_${km}" | sed 's/\//_/'))
	cd src/qmk/qmk_firmware; qmk compile -kb tmp/${KB}/${KR} -km ${KM}
	cp src/qmk/qmk_firmware/.build/tmp_${FILE}.hex keyboards/${KB}/qmk/qmk_firmware/.build/${FILE}.hex | true
	cp src/qmk/qmk_firmware/.build/tmp_${FILE}.uf2 keyboards/${KB}/qmk/qmk_firmware/.build/${FILE}.uf2 | true

qmk-flash:
	$(eval KB := ${kb})
	$(eval KR := ${kr})
	$(eval KM := ${km})
	cd src/qmk/qmk_firmware; qmk flash -kb tmp/${KB}/${KR} -km ${KM}

qmk-init-all:
	kb=crkbd make qmk-init
	kb=cornelius make qmk-init
	kb=lskbd make qmk-init

qmk-compile-all:
	kb=crkbd kr=rev1 km=via make qmk-compile
	kb=crkbd kr=rev4/standard km=via make qmk-compile
	kb=crkbd kr=rev4/mini km=via make qmk-compile
	kb=cornelius kr=rev1 km=via make qmk-compile
	kb=cornelius kr=rev2 km=via make qmk-compile
	kb=lskbd kr=rev1 km=via make qmk-compile

