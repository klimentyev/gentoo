# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils

DESCRIPTION="Advanced command line hexadecimal editor and more"
HOMEPAGE="http://www.radare.org"
SRC_URI="http://cloud.radare.org/get/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssl"

RDEPEND="
	ssl? ( dev-libs/openssl:= )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"
src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.9.9-nogit.patch
	epatch "${FILESDIR}"/${P}-openssl-1.1.0c.patch
}

src_configure() {
	econf \
		$(use_with ssl openssl)
}

src_install() {
	# a workaround for unstable $(INSTALL) call, bug #574866
	local d
	for d in doc/*; do
		if [[ -d $d ]]; then
			rm -rfv "$d" || die "failed to delete '$d'"
		fi
	done

	default
}
