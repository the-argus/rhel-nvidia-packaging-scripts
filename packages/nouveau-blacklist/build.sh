#!/bin/sh

VERSION="0.0.1"

# tar the sources
tar -czf SOURCES/nouveau-blacklist-${VERSION}.tar.gz ./SOURCES/*

# patch the .spec file
sed -i "s/__VERSION__/${VERSION}/g" ./SPECS/nouveau-blacklist.spec

# perform build
rpmbuild --define "%_topdir $(pwd)" -v -ba ./SPECS/nouveau-blacklist.spec
