# rhel-nvidia-packaging-scripts

A configurable set of scripts for building and packing the nvidia drivers on
RHEL systems.

## Tested Versions

The following NVIDIA driver versions have been confirmed to build on rhel 7:

- 470.141.03
- 530.30.02

Before trying a new version, confirm that there exists a branch at [the NVIDIA
driver packaging repo](https://github.com/NVIDIA/yum-packaging-nvidia-driver)
for your RHEL and driver version. For example, if you want to package 525.89.02
on a RHEL 7 machine, make sure that the branch ``525-rhel7`` exists in that
repository.

## Usage

1. Configure your build. Open the ``config`` file and alter the version if
necessary.
2. Run ``main.sh``.
3. Verify that all the packages are present inside of the ``$OUTPUT`` directory
(``rpm-nvidia/`` by default). The generated packages should be the following:

    - ``kmod-nvidia-latest-dkms``
    - ``nvidia-driver-latest-dkms``
    - ``nvidia-driver-latest-dkms-cuda``
    - ``nvidia-driver-latest-dkms-cuda-libs``
    - ``nvidia-driver-latest-dkms-devel``
    - ``nvidia-driver-latest-dkms-libs``
    - ``nvidia-driver-latest-dkms-NvFBCOpenGL``
    - ``nvidia-driver-latest-dkms-NVML``
    - ``nvidia-modprobe-latest-dkms``
    - ``nvidia-kmod-common``
    - ``nvidia-modprobe-latest-dkms``
    - ``nvidia-persistenced-latest-dkms``
    - ``nvidia-xconfig-latest-dkms``
    - And potentially ``nvidia-settings`` (see [known issues](#known-issues))

4. Create a repository in order to install the generated packages. For testing
purposes, try the following:

    1. Modify the ``custom.repo`` file in the root of this directory so that
    it's file URI points to the generated ``rpm-nvidia`` directory by absolute
    path.
    2. Move ``custom.repo`` to ``/etc/yum.repos.d/``.
    3. Run ``createrepo -v --database rpm-nvidia``. You may need to change
    rpm-nvidia to the path to rpm-nvidia if the folder is not in your CWD.
    4. Run ``yum clean all``.
    5. Install the packages with ``yum install nvidia-driver-latest-dkms``.

5. In order to disable the nouveau driver, run the ``misc.sh`` file as well. It
will build an RPM and put it in your repos folder. You will then need to re-run
the ``createrepo`` and ``yum clean`` commands from earlier. Then run
``yum install nouveau-blacklist``.

## Known Issues

The .spec file for ``nvidia-settings`` needs to be patched to
remove the requirement for ``libnvidia-gtk3.so.470.141.03``. However, the actual
driver does not always directly depend on the settings package, so most can just
ignore this error.
