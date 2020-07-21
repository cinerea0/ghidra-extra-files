VERSION = "9.1.2"
DATE = $(shell date +"%Y%m%d")

.PHONY : all fetch build install clean

all : fetch build

fetch :
	gradle --init-script gradle/support/fetchDependencies.gradle init

build :
	gradle buildGhidra

install :
	mkdir -p /usr/bin/ghidra
	unzip ./build/dist/ghidra_$(VERSION)_DEV_$(DATE)_linux64.zip
	cp -r ./ghidra_9.1_DEV/* /usr/bin/ghidra/
	chmod -R 0755 /usr/bin/ghidra
	install -m 0644 ./ghidra.desktop /usr/share/applications/
	install -m 0644 ./icons/48x48/ghidra.png /usr/share/icons/hicolor/48x48/apps/
	install -m 0644 ./icons/64x64/ghidra.png /usr/share/icons/hicolor/64x64/apps/
	install -m 0644 ./icons/128x128/ghidra.png /usr/share/icons/hicolor/128x128/apps/
	install -m 0644 ./icons/256x256/ghidra.png /usr/share/icons/hicolor/256x256/apps/

clean :
	rm -rf ./build
	rm -rf ./flatRepo
	rm -rf ./Ghidra/Features/GhidraServer/build
	rm -rf /GhidraBuild/EclipsePlugins/GhidraDev/GhidraDevPlugin/build
	-pkill -f ".*GradleDaemon*."

