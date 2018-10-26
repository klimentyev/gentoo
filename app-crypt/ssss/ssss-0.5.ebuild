# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit toolchain-funcs

DESCRIPTION="Shamir's Secret Sharing Scheme"
HOMEPAGE="http://point-at-infinity.org/ssss/"
SRC_URI="http://point-at-infinity.org/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
SLOT="0"

RDEPEND="dev-libs/gmp:0="
DEPEND="${RDEPEND}"
BDEPEND="app-doc/xmltoman"

src_prepare() {
	tc-export CC

	# Respect users CFLAGS and don't strip
	sed -e 's/-O2/$(CFLAGS)/g' -e '/strip/d' -i Makefile || die

	default
}

src_install() {
	dobin ssss-split
	dosym ssss-split /usr/bin/ssss-combine

	doman ssss.1

	dodoc HISTORY THANKS
	docinto html
	dodoc doc.html ssss.1.html
}
