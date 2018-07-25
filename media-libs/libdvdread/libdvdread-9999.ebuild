# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools multilib-minimal

DESCRIPTION="Library for DVD navigation tools"
HOMEPAGE="https://www.videolan.org/developers/libdvdnav.html"
if [[ ${PV} = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://code.videolan.org/videolan/libdvdread.git"
else
	SRC_URI="https://downloads.videolan.org/pub/videolan/libdvdread/${PV}/${P}.tar.bz2"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+css static-libs"

RDEPEND="css? ( >=media-libs/libdvdcss-1.3.0[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS TODO README )

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	local myeconfargs=(
		--enable-shared
		$(use_enable static-libs static)
		$(use_with css libdvdcss)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

multilib_src_install_all() {
	find "${ED}" -name "*.la" -delete || die
}
