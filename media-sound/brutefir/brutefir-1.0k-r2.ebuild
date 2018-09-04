# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit toolchain-funcs

DESCRIPTION="Software convolution engine for applying long FIR filters"
HOMEPAGE="https://www.ludd.luth.se/~torger/brutefir.html"
SRC_URI="http://www.ludd.luth.se/~torger/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="media-libs/alsa-lib
	media-sound/jack-audio-connection-kit
	sci-libs/fftw:3.0"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${P}-ld.patch )

src_compile() {
	tc-export AS CC
	emake
}

src_install() {
	emake LIBDIR="/usr/$(get_libdir)" DESTDIR="${D}" \
		install
	dodoc CHANGES README

	insinto /usr/share/${PN}
	doins xtc_config directpath.txt crosspath.txt massive_config \
		bench1_config bench2_config bench3_config bench4_config \
		bench5_config
}

pkg_postinst() {
	elog "Brutefir is a complicated piece of software. Please"
	elog "read the documentation first! You can find"
	elog "documentation here: http://www.ludd.luth.se/~torger/brutefir.html"
	elog "Example config files are in /usr/share/brutefir"
}
