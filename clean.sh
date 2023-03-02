#!/bin/sh

SCRIPT_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$SCRIPT_DIR" ]]; then SCRIPT_DIR="$PWD"; fi
source $SCRIPT_DIR/config

if [ "$1" == "deep" ]; then
    rm -rf $BUILDDIR
fi

rm -rf $OUTPUT
rm -rf $ROOT/*.run
