# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Dos2Unix like text file converter"
HOMEPAGE="http://www.megaloman.com/~hany/software/hd2u/"
SRC_URI="http://www.megaloman.com/~hany/_data/hd2u/${P}.tgz"

KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="
	dev-libs/popt"
RDEPEND="${DEPEND}
	!app-text/dos2unix"

PATCHES=(
	"${FILESDIR}"/${PN}-1.0.3-build.patch
)
