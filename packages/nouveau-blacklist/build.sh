#!/bin/sh

VERSION="0.0.1"

# tar the sources
mkdir "nouveau-blacklist-${VERSION}"
mv SOURCES/* nouveau-blacklist-${VERSION}

tar -czf SOURCES/nouveau-blacklist-${VERSION}.tar.gz nouveau-blacklist-${VERSION}

# patch the .spec file
sed -i "s/__VERSION__/${VERSION}/g" ./SPECS/nouveau-blacklist.spec

# perform build
rpmbuild --define "%_topdir $(pwd)" -v -ba ./SPECS/nouveau-blacklist.spec
