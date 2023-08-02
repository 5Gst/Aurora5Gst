Name:       ru.auroraos.InnoAurora5Gst

Summary:    My Aurora OS Application
Version:    0.1
Release:    1
Group:      Qt/Qt
License:    BSD-3-Clause
URL:        https://auroraos.ru
Source0:    %{name}-%{version}.tar.bz2

Requires:   sailfishsilica-qt5 >= 0.10.9
BuildRequires:  pkgconfig(auroraapp)
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  desktop-file-utils

#TODO add requirements
#BuildRequires:  gcc 
#BuildRequires:  gcc-c++
#BuildRequires:  make
#BuildRequires:  automake


%description
Short description of my Aurora OS Application

%prep
%setup -q -n %{name}-%{version}

%build
%qmake5
%make_build
mkdir -p iPerf2_build
pushd iPerf2_build
%{_sourcedir}/../iPerf2/configure --prefix=/usr || echo 'F*ck iPerv' | tee /dev/full
make -j%{getncpus}
popd

%install
rm -rf %{buildroot}
%qmake5_install
pushd iPerf2_build
make install-exec DESTDIR=%{buildroot}
popd

desktop-file-install --delete-original         --dir %{buildroot}%{_datadir}/applications                %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
%{_bindir}
%defattr(644,root,root,-)
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor/*/apps/%{name}.png
