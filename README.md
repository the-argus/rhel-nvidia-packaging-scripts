# rhel-nvidia-packaging-scripts

A configurable set of scripts for building and packing the nvidia drivers on
RHEL systems.

## Usage

When finished, you have to run the following two commands for some reason (they
should be automatically run by the package...)

```bash
PATH=/opt/rh/devtoolset-9/root/bin:$PATH dkms build -m nvidia -v 470.141.03
PATH=/opt/rh/devtoolset-9/root/bin:$PATH dkms install -m nvidia -v 470.141.03
```

## Known Issues

For version 470.141.03, ``nvidia-settings`` .spec file needs to be patched to
remove the requirement for ``libnvidia-gtk3.so.470.141.03``.
