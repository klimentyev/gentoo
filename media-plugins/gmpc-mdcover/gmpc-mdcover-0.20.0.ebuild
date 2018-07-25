# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Plugin for fetching cover art, artist art, album and artist information"
HOMEPAGE="http://gmpc.wikia.com/wiki/GMPC_PLUGIN_MDCOVER"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls"

RDEPEND="
	>=media-sound/gmpc-${PV}
	dev-libs/libxml2:=
	|| (
		x11-libs/gdk-pixbuf:2[jpeg]
		x11-libs/gtk+:2[jpeg]
	)"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? (
		dev-util/intltool
		sys-devel/gettext
	)"

src_configure() {
	econf $(use_enable nls)
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
