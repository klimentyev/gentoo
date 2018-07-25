# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit fixheadtails toolchain-funcs

DESCRIPTION="tool for applying patches that patch cannot apply because of conflicting changes"
HOMEPAGE="https://neil.brown.name/wiggle https://neil.brown.name/git?p=wiggle"
SRC_URI="https://neil.brown.name/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

# The 'p' tool does support bitkeeper, but I'm against just dumping it in here
# due to it's size.  I've explictly listed every other dependancy here due to
# the nature of the shell program 'p'
RDEPEND="
	dev-util/diffstat
	dev-util/patchutils
	sys-apps/diffutils
	sys-apps/findutils
	virtual/awk
	sys-apps/grep
	sys-apps/less
	sys-apps/sed
	sys-apps/coreutils
	sys-devel/patch
	sys-libs/ncurses:0=
	"
DEPEND="${RDEPEND}
	sys-apps/groff
	virtual/pkgconfig
	test? ( sys-process/time )"

PATCHES=( "${FILESDIR}"/${P}-cflags.patch )

src_prepare() {
	default

	# Fix the reference to the help file so `p help' works
	sed -i "s:\$0.help:${EPREFIX}/usr/share/wiggle/p.help:" p || die "sed failed on p"

	ht_fix_file p
}

src_compile() {
	emake CC="$(tc-getCC)" ${PN}
}

src_test() {
	# Use prefixed time binary
	emake TIME_CMD="${EPREFIX}/usr/bin/time" test
}

src_install() {
	dobin wiggle p
	doman wiggle.1
	dodoc ANNOUNCE INSTALL TODO DOC/Algorithm notes
	insinto /usr/share/wiggle
	doins p.help
}
