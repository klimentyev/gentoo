# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="list resources in widgets"
HOMEPAGE="https://www.x.org/wiki/ https://cgit.freedesktop.org/"
SRC_URI="mirror://xorg/app/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

BDEPEND="
	virtual/pkgconfig
"
RDEPEND="
	x11-libs/libX11
	x11-libs/libXaw
	x11-libs/libXmu
	x11-libs/libXt
"
DEPEND="${RDEPEND}"
