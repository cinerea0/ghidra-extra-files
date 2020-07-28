# ghidra-extra-files

This repository contains files that should be added to release tarballs of Ghidra before attempting to make a debian package from it. The `ghidraPrep.sh` script automatically downloads a Ghidra release and applies these changes. The script can be used by running `./ghidraPrep.sh VERSION` where "VERSION" is replaced by the version of Ghidra you want to package. For example, `ghidraPrep.sh 9.1.2`.

References for pages useful in the packaging and PPA uploading process:
* [debuild man page](https://manpages.debian.org/jessie/devscripts/debuild.1.en.html)
* [Ubuntu packaging overview](https://packaging.ubuntu.com/html/packaging-new-software.html)
* [PPA Overview](https://help.launchpad.net/Packaging/PPA)
* [Building for a PPA](https://help.launchpad.net/Packaging/PPA/BuildingASourcePackage)
* [Uploading to a PPA](https://help.launchpad.net/Packaging/PPA/Uploading)
