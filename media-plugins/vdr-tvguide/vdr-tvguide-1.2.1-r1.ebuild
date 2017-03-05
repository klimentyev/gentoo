# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MY_P="${P/vdr-}"

VERSION="1627"

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: highly customizable 2D EPG viewer"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-tvguide"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	media-plugins/vdr-epgsearch
	virtual/imagemagick-tools"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	vdr-plugin-2_src_prepare

	if has_version media-gfx/graphicsmagick; then
		sed -i -e 's:^IMAGELIB =.*:IMAGELIB = graphicsmagick:' Makefile
	fi
}

pkg_postinst() {
	vdr-plugin-2_pkg_postinst

	einfo "See http://projects.vdr-developer.org/projects/skin-nopacity/wiki"
	einfo "for more information about how to use channel logos"
}
