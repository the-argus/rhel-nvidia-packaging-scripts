#!/bin/sh

# based on https://developer.download.nvidia.com/compute/github-demos/yum-packaging-nvidia-driver/guide-rhel7/

# TODO: fix nvidia-driver-latest-dkms-470.141.03-1.el7_9.x86_64 so that it does not provide this: /usr/share/X11/xorg.conf.d/10-nvidia-driver.conf
# most students want to use nvidia driver for computation and not display

# TODO: package /etc/modprobe.d/nouveau-blacklist.conf

SCRIPT_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$SCRIPT_DIR" ]]; then SCRIPT_DIR="$PWD"; fi

# settings. these are used both by this script and by the nvidia driver build scripts
source $SCRIPT_DIR/config
source $SCRIPT_DIR/stages/01-yum-install
source $SCRIPT_DIR/stages/02-git-clone-driver-dkms
source $SCRIPT_DIR/stages/03-download-runfile
source $SCRIPT_DIR/stages/04-build-tarballs
source $SCRIPT_DIR/stages/05-build-driver
source $SCRIPT_DIR/stages/06-build-dkms
source $SCRIPT_DIR/stages/07-build-kmod-common
source $SCRIPT_DIR/stages/08-build-modprobe-common
source $SCRIPT_DIR/stages/09-build-persistenced
source $SCRIPT_DIR/stages/10-build-settings
source $SCRIPT_DIR/stages/11-build-xconfig
source $SCRIPT_DIR/stages/12-build-yum-plugin

# declare some variables
TARTYPE=
RUNFILENAME=NVIDIA-Linux-x86_64-${VERSION}.run
# CUDA_RUNFILENAME=cuda_${CUDA_VERSION}_${VERSION}_linux.run
MODPROBE_FILENAME=
PERSISTENCED_FILENAME=
SETTINGS_FILENAME=
XCONFIG_FILENAME=
RUNFILE_URL=http://us.download.nvidia.com/XFree86/Linux-${ARCH}/${VERSION}/${RUNFILENAME}
# CUDA_RUNFILE_URL=https://developer.download.nvidia.com/compute/cuda/${CUDA_VERSION}/local_installers/${CUDA_RUNFILENAME}
PERSISTENCED_URL=
MODPROBE_URL=
SETTINGS_URL=
XCONFIG_URL=
ACTUAL_VERSION=

# stage 1
yum_install

mkdir -p $BUILDDIR
mkdir -p $OUTPUT

pushd $BUILDDIR > /dev/null
git_clone_driver_dkms
download_runfile
pushd yum-packaging-nvidia-driver > /dev/null
build_tarballs
build_driver
popd > /dev/null
pushd yum-packaging-dkms-nvidia > /dev/null
build_dkms
popd > /dev/null

# build kmod, this doesn't involve compilation so it should be fast
build_kmod_common
build_modprobe_common
build_persistenced
build_settings
build_xconfig
build_yum_plugin
popd > /dev/null
