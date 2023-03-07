Name:           nouveau-blacklist
Version:        __VERSION__
Release:        1%{?dist}
Summary:        Disable the nouveau driver
BuildArch:      noarch

License:        GPL
Source0:        %{name}-%{version}.tar.gz

%description
Blacklists the nouveau kernel module. Useful when nouveau is loading before the
proprietary driver and preventing it from controlling video devices.

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/etc/modprobe.d
cp nouveau-blacklist.conf $RPM_BUILD_ROOT/etc/modprobe.d/

%files
/etc/modprobe.d/nouveau-blacklist.conf

%changelog
* Tue Mar 07 2023 Ian McFarlane <ifmeec@rit.edu> -
0.0.1
- Initial package setup
