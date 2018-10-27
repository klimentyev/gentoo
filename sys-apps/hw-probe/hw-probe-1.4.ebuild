# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Probe for hardware, check operability and upload result to the Linux HW database"
HOMEPAGE="https://github.com/linuxhw/hw-probe/"
SRC_URI="https://github.com/linuxhw/hw-probe/archive/1.4.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="acpi cpuid hdparm hplip i2c inxi mcelog memtester mesa pnp rfkill scanner smartcard sysstat systemd vaapi vulkan xinput"

RDEPEND="dev-lang/perl
	net-misc/curl
	sys-apps/dmidecode
	sys-apps/edid-decode
	sys-apps/hwinfo
	sys-apps/pciutils
	sys-apps/smartmontools
	sys-apps/usbutils
	virtual/perl-Data-Dumper
	virtual/perl-Digest-SHA
	acpi? ( sys-power/iasl )
	cpuid? ( sys-apps/cpuid )
	hdparm? ( sys-apps/hdparm )
	hplip? ( net-print/hplip )
	i2c? ( sys-apps/i2c-tools )
	inxi? ( sys-apps/inxi )
	mcelog? ( app-admin/mcelog )
	memtester? ( sys-apps/memtester )
	mesa? ( x11-apps/mesa-progs )
	pnp? ( sys-apps/pnputils )
	rfkill? ( net-wireless/rfkill )
	scanner? ( media-gfx/sane-backends )
	smartcard? ( dev-libs/opensc )
	sysstat? ( app-admin/sysstat )
	systemd? ( sys-apps/systemd )
	vaapi? ( x11-libs/libva )
	amd64? ( vulkan? ( dev-util/vulkan-tools ) )
	xinput? ( x11-apps/xinput )"

PATCHES=( "${FILESDIR}/${P}-makefile.patch" )

src_compile() {
	:;
}
