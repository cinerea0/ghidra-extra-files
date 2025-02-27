#!/bin/bash
#The argument to this script is based on the assumption that Iconoclasm's tags for new Ghidra releases are just the version number (e.g. 9.1.2)
#If the tags are a different format (e.g. Ghidra_9.1.2_build), then a line can be added to extract the version number

echo "Fetching tarball"
wget "https://github.com/NationalSecurityAgency/ghidra/archive/Ghidra_$1_build.tar.gz"

echo "Extracting tarball"
tar -xzf Ghidra_$1_build.tar.gz

echo "Inserting and fixing files"
cp -R icons ghidra-Ghidra_$1_build
cp ghidra.desktop ghidra-Ghidra_$1_build
sed -i "s/VERSION = \"\"/VERSION = \"$1\"/g" Makefile
cp Makefile ghidra-Ghidra_$1_build
sed -i "s/^application.version=.*/application.version=$1/g" ghidra-Ghidra_$1_build/Ghidra/application.properties

echo "Moving files into a separate directory"
mkdir -p $HOME/ghidra/ghidra_$1
cp -R ghidra-Ghidra_$1_build/* $HOME/ghidra/ghidra_$1/

echo "Cleaning up"
rm Ghidra_$1_build.tar.gz
rm -R ghidra-Ghidra_$1_build

echo "Navigate to $HOME/ghidra/ghidra_$1 and execute 'debuild -S -sa' to build the package."
