# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit desktop eutils gnome2-utils unpacker

TIMESTAMP="${PV:4:2}${PV:6:2}${PV:0:4}"
DESCRIPTION="A minimal action game by Terry Cavanagh, with music by Chipzel"
HOMEPAGE="https://www.superhexagon.com/"
SRC_URI="superhexagon-${TIMESTAMP}-bin"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="bindist fetch splitdebug"

MYGAMEDIR="/opt/${PN}"
QA_PREBUILT="${MYGAMEDIR#/}/superhexagon"

DEPEND="app-arch/unzip"

RDEPEND="media-libs/glew:1.6
	media-libs/libsdl2[opengl,sound,video]
	media-libs/libvorbis
	media-libs/openal
	virtual/glu
	virtual/opengl"

S="${WORKDIR}/data"
DOCS=( Linux.README )

pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to your distfiles directory."
}

src_unpack() {
	unpack_zip ${A}
}

src_install() {
	local myarch=$(usex amd64 x86_64 x86)

	exeinto "${MYGAMEDIR}"
	insinto "${MYGAMEDIR}"
	newexe ${myarch}/superhexagon.${myarch} superhexagon
	doins -r data SuperHexagon.png

	make_wrapper ${PN} ./superhexagon "${MYGAMEDIR}"
	newicon -s 512 SuperHexagon.png ${PN}.png
	make_desktop_entry ${PN}

	einstalldocs
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
