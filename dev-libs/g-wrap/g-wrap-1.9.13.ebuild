# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit eutils

DESCRIPTION="A tool for exporting C libraries into Scheme"
HOMEPAGE="http://www.nongnu.org/g-wrap/"
SRC_URI="http://download.savannah.gnu.org/releases/g-wrap/old/${P}.tar.gz"
KEYWORDS="amd64 ~hppa ppc ppc64 x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

# guile-lib for srfi-34, srfi-35
RDEPEND="
	dev-libs/glib:2
	dev-scheme/guile-lib
	dev-scheme/guile[deprecated]
	virtual/libffi"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/indent"

MAKEOPTS+=" -j1"

src_configure() {
	econf --disable-Werror --with-glib
}
