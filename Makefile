.PHONY: git-submodule, qmk-clean, qmk-init, qmk-compile, qmk-flash, qmk-init-all, qmk-compile-all, vial-qmk-clean, vial-qmk-init, vial-qmk-compile, vial-qmk-flash, vial-qmk-init-all, vial-qmk-compile-all, update-all

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
	mkdir -p keyboards/${KB}/qmk/qmk_firmware/.build

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
	kb=crkbd kr=rev4_0/standard km=via make qmk-compile
	kb=crkbd kr=rev4_0/mini km=via make qmk-compile
	kb=crkbd kr=rev4_1/standard km=via make qmk-compile
	kb=crkbd kr=rev4_1/mini km=via make qmk-compile
	kb=cornelius kr=rev1 km=via make qmk-compile
	kb=cornelius kr=rev2 km=via make qmk-compile
	kb=lskbd kr=rev1 km=via make qmk-compile

vial-qmk-clean:
	rm -rf src/vial-kb/vial-qmk/keyboards/tmp
	cd src/vial-kb/vial-qmk; qmk clean

vial-qmk-init:
	$(eval KB := ${kb})
	rm -rf src/vial-kb/vial-qmk/keyboards/tmp/${KB}
	mkdir -p src/vial-kb/vial-qmk/keyboards/tmp/${KB}
	cp -r $(shell pwd)/keyboards/${KB}/qmk/qmk_firmware/* src/vial-kb/vial-qmk/keyboards/tmp/${KB}
	rm -rf src/vial-kb/vial-qmk/keyboards/tmp/${KB}/keymaps
	ln -s $(shell pwd)/keyboards/${KB}/vial-kb/vial-qmk/keymaps src/vial-kb/vial-qmk/keyboards/tmp/${KB}/keymaps
	mkdir -p keyboards/${KB}/vial-kb/vial-qmk/.build

vial-qmk-compile:
	$(eval KB := ${kb})
	$(eval KR := ${kr})
	$(eval KM := ${km})
	$(eval FILE := $(shell echo "${kb}_${kr}_${km}" | sed 's/\//_/'))
	cd src/vial-kb/vial-qmk; qmk compile -kb tmp/${KB}/${KR} -km ${KM}
	cp src/vial-kb/vial-qmk/.build/tmp_${FILE}.hex keyboards/${KB}/vial-kb/vial-qmk/.build/${FILE}.hex | true
	cp src/vial-kb/vial-qmk/.build/tmp_${FILE}.uf2 keyboards/${KB}/vial-kb/vial-qmk/.build/${FILE}.uf2 | true

vial-qmk-flash:
	$(eval KB := ${kb})
	$(eval KR := ${kr})
	$(eval KM := ${km})
	cd src/vial-kb/vial-qmk; qmk flash -kb tmp/${KB}/${KR} -km ${KM}

vial-qmk-init-all:
	kb=crkbd make vial-qmk-init
	kb=cornelius make vial-qmk-init
	kb=lskbd make vial-qmk-init

vial-qmk-compile-all:
	kb=crkbd kr=rev4_0/standard km=vial make vial-qmk-compile
	kb=crkbd kr=rev4_0/mini km=vial_mini make vial-qmk-compile
	kb=crkbd kr=rev4_1/standard km=vial make vial-qmk-compile
	kb=crkbd kr=rev4_1/mini km=vial_mini make vial-qmk-compile
	kb=cornelius kr=rev2 km=vial make vial-qmk-compile
	kb=lskbd kr=rev1 km=vial make vial-qmk-compile

update-all:
	make git-submodule
	make qmk-clean
	make qmk-init-all
	make qmk-compile-all
	make vial-qmk-clean
	make vial-qmk-init-all
	make vial-qmk-compile-all
