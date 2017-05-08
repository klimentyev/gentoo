# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils cmake-utils

DESCRIPTION="Development library for simulation games"
HOMEPAGE="http://www.simgear.org/"
SRC_URI="mirror://sourceforge/flightgear/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="+dns debug subversion test"

#NOTE: current head works with osg-3.5.5
COMMON_DEPEND="
	dev-libs/expat
	>=dev-games/openscenegraph-3.2.0
	<dev-games/openscenegraph-3.5.2
	media-libs/openal
	net-misc/curl
	sys-libs/zlib
	virtual/opengl
	dns? ( net-libs/udns )
"
DEPEND="${COMMON_DEPEND}
	>=dev-libs/boost-1.44
"
RDEPEND="${COMMON_DEPEND}
	subversion? ( dev-vcs/subversion )
"

DOCS=(AUTHORS ChangeLog NEWS README Thanks)

src_configure() {
	local mycmakeargs=(
		-DENABLE_DNS=$(usex dns)
		-DENABLE_PKGUTIL=ON
		-DENABLE_RTI=OFF
		-DENABLE_SIMD=ON
		-DENABLE_SOUND=ON
		-DENABLE_TESTS=$(usex test)
		-DSIMGEAR_HEADLESS=OFF
		-DSIMGEAR_SHARED=ON
		-DSYSTEM_EXPAT=ON
		-DSYSTEM_UDNS=ON
		-DUSE_AEONWAVE=OFF
		-DOSG_FSTREAM_EXPORT_FIXED=OFF # TODO perhaps track it
	)
	cmake-utils_src_configure
}
