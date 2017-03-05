# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="A video-based animated GIF creator"
HOMEPAGE="https://sourceforge.net/projects/qgifer/"
SRC_URI="mirror://sourceforge/${PN}/${P}-source.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug imagemagick opencv3"

RDEPEND="
	>=media-libs/giflib-5.1:=
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	virtual/ffmpeg:0
	imagemagick? ( media-gfx/imagemagick:0 )
	!opencv3? ( <media-libs/opencv-3.0.0:0=[ffmpeg] )
	opencv3? ( >=media-libs/opencv-3.0.0:0=[ffmpeg] )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}-source"

PATCHES=(
	"${FILESDIR}/${P}-desktop.patch"
	# Port to giflib 5 API
	"${FILESDIR}/${P}-giflib5.patch"
)

src_prepare(){
	use opencv3 && PATCHES+=( "${FILESDIR}/${P}-opencv3.patch" )
	cmake-utils_src_prepare

	# Fix the doc path
	sed -i -e "s|share/doc/qgifer|share/doc/${PF}|" CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		 $(usex debug '-DRELEASE_MODE=OFF' '')
	)
	cmake-utils_src_configure
}
