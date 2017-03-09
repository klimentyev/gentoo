# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Commandline utility to convert ID3 tags in mp3 files between different encodings"
HOMEPAGE="http://mp3unicode.sourceforge.net"
SRC_URI="https://github.com/alonbl/${PN}/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/taglib-1.4"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
