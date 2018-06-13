# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Simple programming interface for decoding and encoding audio data using vorbis or speex"
HOMEPAGE="https://www.xiph.org/fishsound/"
SRC_URI="https://downloads.xiph.org/releases/libfishsound/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="flac speex"

RDEPEND="media-libs/libvorbis
	media-libs/libogg
	flac? ( media-libs/flac )
	speex? ( media-libs/speex )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

# bug #395153
RESTRICT="test"

PATCHES=( "${FILESDIR}"/${P}-pc.patch )

src_prepare() {
	sed -i \
		-e 's:doxygen:doxygen-dummy:' \
		configure || die

	default
}

src_configure() {
	local myconf=""
	use flac || myconf="${myconf} --disable-flac"
	use speex || myconf="${myconf} --disable-speex"

	econf \
		--disable-dependency-tracking \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" \
		docdir="${D}/usr/share/doc/${PF}" install
	dodoc AUTHORS ChangeLog README
}
