# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="NCurses Disk Usage"
HOMEPAGE="http://dev.yorhel.nl/ncdu/"
SRC_URI="http://dev.yorhel.nl/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 ppc ppc64 x86 ~amd64-linux ~x86-linux ~x64-macos"

RDEPEND="
	sys-libs/ncurses:0=[unicode]
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"
