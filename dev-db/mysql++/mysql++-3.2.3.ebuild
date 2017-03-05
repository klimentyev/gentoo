# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="C++ API interface to the MySQL database"
HOMEPAGE="http://tangentsoft.net/mysql++/"
SRC_URI="http://www.tangentsoft.net/mysql++/releases/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0/3"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86 ~amd64-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc"

RDEPEND="virtual/libmysqlclient:="
DEPEND="${RDEPEND}"
DOCS=( CREDITS.txt HACKERS.txt Wishlist doc/ssqls-pretty )

src_prepare() {
	eapply "${FILESDIR}/${PN}-3.2.1-gold.patch"
	eapply_user
	# Current MySQL libraries are always with threads and slowly being removed
	sed -i -e "s/mysqlclient_r/mysqlclient/" "${S}/configure" || die
	rm "${S}/doc/"README-*-RPM.txt || die
}

src_configure() {
	local myconf="--enable-thread-check --with-mysql=${EPREFIX}/usr"
	econf ${myconf}
}

src_install() {
	default
	# install the docs and HTML pages
	use doc && dodoc -r doc/pdf/ doc/refman/ doc/userman/ doc/html/
}
