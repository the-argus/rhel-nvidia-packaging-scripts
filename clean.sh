#!/bin/sh

source ./config

if [ "$1" == "deep" ]; then
    rm -rf $BUILDDIR
fi

rm -rf $OUTPUT
