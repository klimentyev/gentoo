# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

NETSURF_BUILDSYSTEM=buildsystem-1.5
inherit netsurf

DESCRIPTION="CSS parser and selection engine, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/libcss/"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm ~ppc ~m68k-mint"
IUSE="test"

RDEPEND=">=dev-libs/libparserutils-0.2.1-r1[static-libs?,${MULTILIB_USEDEP}]
	>=dev-libs/libwapcaplet-0.4.0[static-libs?,${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( dev-lang/perl )"

src_prepare() {
	sed -e '1i#pragma GCC diagnostic ignored "-Wimplicit-fallthrough"' \
		-i src/parse/parse.c || die
	sed -e '1i#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"' \
		-i src/parse/parse.c src/select/computed.c || die

	netsurf_src_prepare
}
