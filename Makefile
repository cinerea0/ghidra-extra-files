.PHONY : all fetch build install clean

all : fetch build

fetch :
	mkdir flatRepo  # make flatRepo directory
	# fetch and place dex2jar
	curl -OL https://github.com/pxb1988/dex2jar/releases/download/2.0/dex-tools-2.0.zip
	unzip dex-tools-2.0.zip
	mv dex2jar-2.0/lib/dex-*.jar ./flatRepo/
	rm -f dex-tools-2.0.zip
	rm -rf dex2jar-2.0
	# fetch and place AXMLPrinter2
	curl -OL https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/android4me/AXMLPrinter2.jar
	mv AXMLPrinter2.jar ./flatRepo/
	# fetch and place hfsexplorer libs
	curl -OL https://sourceforge.net/projects/catacombae/files/HFSExplorer/0.21/hfsexplorer-0_21-bin.zip
	unzip hfsexplorer-0_21-bin.zip -d ./hsfx/
	mv ./hsfx/lib/csframework.jar ./flatRepo/
	mv ./hsfx/lib/hfsx_dmglib.jar ./flatRepo/
	mv ./hsfx/lib/hfsx.jar ./flatRepo/
	mv ./hsfx/lib/iharder-base64.jar ./flatRepo/
	rm -f hfsexplorer-0_21-bin.zip
	rm -rf hsfx
	# fetch and place yajsw
	mkdir -p ./ghidra/Ghidra/Features/GhidraServer/build/
	curl -OL https://sourceforge.net/projects/yajsw/files/yajsw/yajsw-stable-12.12/yajsw-stable-12.12.zip
	mv yajsw-stable-12.12.zip ./ghidra/Ghidra/Features/GhidraServer/build/
	# fetch and place Eclipse CDT
	mkdir -p ./ghidra/GhidraBuild/EclipsePlugins/GhidraDev/GhidraDevPlugin/build/
	curl -OL 'http://www.eclipse.org/downloads/download.php?r=1&protocol=https&file=/tools/cdt/releases/8.6/cdt-8.6.0.zip'
	curl -o 'cdt-8.6.0.zip.sha512' -L --retry 3 'https://www.eclipse.org/downloads/sums.php?type=sha512&file=/tools/cdt/releases/8.6/cdt-8.6.0.zip'
	shasum -a 512 -c 'cdt-8.6.0.zip.sha512'
	mv cdt-8.6.0.zip ./ghidra/GhidraBuild/EclipsePlugins/GhidraDev/GhidraDevPlugin/build/
	rm -f cdt-8.6.0.zip.sha512
	# fetch and place PyDev
	curl -L -o 'PyDev 6.3.1.zip' https://sourceforge.net/projects/pydev/files/pydev/PyDev%206.3.1/PyDev%206.3.1.zip
	mv 'PyDev 6.3.1.zip' ./ghidra/GhidraBuild/EclipsePlugins/GhidraDev/GhidraDevPlugin/build/

build :
	-gradle --info buildGhidra  # remove --info when finished testing
	gradle sleighCompile  # ask Lucien if he wants all modules precompiled (triples build time)

install :
	mkdir -p /usr/bin/ghidra
	cp -r ./build/dist/ghidra_9.1_DEV/* /usr/bin/ghidra/
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

