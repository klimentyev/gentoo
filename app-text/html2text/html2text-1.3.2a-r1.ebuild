# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="A HTML to text converter"
HOMEPAGE="http://www.mbayer.de/html2text/"
SRC_URI="http://www.mbayer.de/html2text/downloads/${P}.tar.gz
	http://www.mbayer.de/html2text/downloads/patch-utf8-${P}.diff
	http://www.mbayer.de/html2text/downloads/patch-amd64-${P}.diff
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"

PATCHES=(
	"${FILESDIR}/${PN}-1.3.2a-compiler.patch"
	"${FILESDIR}/${PN}-1.3.2a-urlistream-get.patch"
	"${DISTDIR}/patch-utf8-${PN}-1.3.2a.diff"
	"${DISTDIR}/patch-amd64-${PN}-1.3.2a.diff"
)

src_prepare() {
	tc-export CXX
	default
}

src_compile() {
	emake LDFLAGS="${LDFLAGS}" DEBUG="${CXXFLAGS}"
}

src_install() {
	dobin html2text
	doman html2text.1.gz html2textrc.5.gz
	dodoc CHANGES CREDITS KNOWN_BUGS README TODO
}
