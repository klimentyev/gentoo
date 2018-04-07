# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CMAKE_MAKEFILE_GENERATOR=emake
COMMIT=30e8c507df7278b92963045d0c874217db7bd3f7
inherit cmake-utils desktop xdg-utils

DESCRIPTION="A turn-based strategy, artillery, action and comedy game"
HOMEPAGE="https://www.hedgewars.org/"
SRC_URI="https://github.com/${PN}/hw/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 Apache-2.0 FDL-1.3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libav server"

QA_FLAGS_IGNORED="/usr/bin/hwengine"
QA_PRESTRIPPED="/usr/bin/hwengine"

# qtcore:5= - depends on private header
CDEPEND="
	>=dev-games/physfs-3.0.1
	dev-lang/lua:0=
	dev-qt/qtcore:5=
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	media-libs/libpng:0=
	media-libs/libsdl2:=
	media-libs/sdl2-image:=
	media-libs/sdl2-mixer:=[vorbis]
	media-libs/sdl2-net:=
	media-libs/sdl2-ttf:=
	sys-libs/zlib:=
	libav? ( media-video/libav:= )
	!libav? ( media-video/ffmpeg:= )"
DEPEND="${CDEPEND}
	>=dev-lang/fpc-2.4
	dev-qt/linguist-tools:5
	server? (
		>=dev-lang/ghc-6.10
		dev-haskell/vector
		>=dev-haskell/network-2.3
		dev-haskell/random
		>=dev-haskell/mtl-2
		dev-haskell/sandi
		dev-haskell/hslogger
		dev-haskell/utf8-string
		dev-haskell/sha
		dev-haskell/entropy
		>=dev-haskell/zlib-0.5.3 <dev-haskell/zlib-0.6
		dev-haskell/regex-tdfa
	)"
RDEPEND="${CDEPEND}
	app-arch/xz-utils
	>=media-fonts/dejavu-2.28
	media-fonts/wqy-zenhei"

S="${WORKDIR}"/hw-${COMMIT}

PATCHES=(
	"${FILESDIR}"/${PN}-0.9.22-rpath-fix.patch
)

src_configure() {
	local mycmakeargs=(
		-DMINIMAL_FLAGS=ON
		-DDATA_INSTALL_DIR="${EPREFIX}/usr/share/${PN}"
		-Dtarget_binary_install_dir="${EPREFIX}/usr/bin"
		-Dtarget_library_install_dir="${EPREFIX}/usr/$(get_libdir)"
		-DNOSERVER=$(usex server FALSE TRUE)
		-DCMAKE_VERBOSE_MAKEFILE=TRUE
		-DPHYSFS_SYSTEM=ON
		# Need to tell the build system where the fonts are located
		# as it uses PhysFS' symbolic link protection mode which
		# prevents us from symlinking the fonts into the right directory
		#   https://hg.hedgewars.org/hedgewars/rev/76ad55807c24
		#   https://icculus.org/physfs/docs/html/physfs_8h.html#aad451d9b3f46f627a1be8caee2eef9b7
		-DFONTS_DIRS="${EPREFIX}/usr/share/fonts/wqy-zenhei;${EPREFIX}/usr/share/fonts/dejavu"
		# upstream sets RPATH that leads to weird breakage
		# https://bugzilla.redhat.com/show_bug.cgi?id=1200193
		-DCMAKE_SKIP_RPATH=ON
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	doman man/${PN}.6
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
