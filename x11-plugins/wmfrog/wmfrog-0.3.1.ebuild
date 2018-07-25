# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2
inherit toolchain-funcs

DESCRIPTION="a weather application, it shows the weather in a graphical way"
HOMEPAGE="http://wiki.colar.net/wmfrog_dockapp"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libXext
	x11-libs/libXpm
	x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-base/xorg-proto"

S=${WORKDIR}/Src

src_prepare() {
	emake clean || die
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" INCDIR="" \
		LIBDIR="" SYSTEM="${LDFLAGS}" || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ../{CHANGES,HINTS} || die
}
