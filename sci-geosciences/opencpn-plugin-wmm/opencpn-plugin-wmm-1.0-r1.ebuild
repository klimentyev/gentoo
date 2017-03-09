# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

WX_GTK_VER="3.0"
inherit cmake-utils wxwidgets

MY_PN="wmm_pi"

DESCRIPTION="World Magnetic Model Plugin for OpenCPN"
HOMEPAGE="http://opencpn.org/ocpn/downloadplugins"
SRC_URI="https://github.com/nohal/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=sci-geosciences/opencpn-4.0.0
	<sci-geosciences/opencpn-4.2.0
	sys-devel/gettext
	x11-libs/wxGTK:${WX_GTK_VER}
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	need-wxwidgets unicode
	cmake-utils_src_prepare
}
