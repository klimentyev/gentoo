# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Automating Software Documentation"
HOMEPAGE="http://www.xs4all.nl/~rfsber/Robo/robodoc.html"
SRC_URI="https://rfsber.home.xs4all.nl/Robo/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND=">=dev-util/ctags-5.3.1"
DEPEND="${RDEPEND}"

src_prepare() {
	# move and sed due to configure.in and autotoolsversion (still only a warning)
	# For more details see:
	# https://bugs.gentoo.org/426262
	mv ./configure.in ./configure.ac
	sed -i -e 's/^dnl/\#/g' ./configure.ac
	eapply -p0 "${FILESDIR}/${P}-Docs-makefile-cleanup.patch"
	eapply_user
	eautoreconf
}

src_configure() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	insinto /usr/share/${PN}
	doins -r Contributions/ || die "doins Contributions/ failed"

	rm -f "${D}"/usr/share/doc/${PF}/{COPYING,INSTALL}

	if use examples; then
		insinto /usr/share/${PN}
		doins -r Examples/PerlExample || die "doins Examples/PerlExample failed"
	fi
}
