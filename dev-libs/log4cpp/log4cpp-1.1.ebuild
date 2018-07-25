# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools multilib-minimal

DESCRIPTION="C++ classes for flexible logging to files, syslog and other destinations"
HOMEPAGE="http://log4cpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/5"
KEYWORDS="amd64 ~arm ppc s390 x86"
IUSE="doc static-libs test"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

PATCHES=(
	"${FILESDIR}"/1.0-doc_install_path.patch
	"${FILESDIR}"/1.0-gcc43.patch
	"${FILESDIR}"/1.0-asneeded.patch
	"${FILESDIR}"/${P}-cmath-fix.patch
	"${FILESDIR}"/${P}-automake-1.13.patch
)

S="${WORKDIR}/${PN}"

MULTILIB_CHOST_TOOLS=(
	/usr/bin/log4cpp-config
)

src_prepare() {
	default

	mv configure.{in,ac} || die

	# Build tests conditionally
	if ! use test; then
		sed -i -e '/^SUBDIRS/s/ tests//' Makefile.am || die
	fi

	eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE=${S} econf \
		--without-idsa \
		$(use_enable doc doxygen) \
		$(use_enable static-libs static)
}

multilib_src_install_all() {
	einstalldocs

	# package installs .pc files
	find "${D}" -name '*.la' -delete || die
}
