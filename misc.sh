#!/bin/sh

# build packages in the packages/directory

source ./config

for dir in ./packages*; do
    if [ ! -d $dir ]; then
        echo "Non-directory $dir found in packages directory. Skipping."
        continue
    fi

    pushd ./packages/$dir > /dev/null

    ./build.sh
    
    # install
    find -name "*.rpm" -exec cp -v {} $OUTPUT/ \;
    
    popd > /dev/null
done
