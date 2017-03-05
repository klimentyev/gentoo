# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils java-pkg-opt-2 multilib toolchain-funcs

DESCRIPTION="Artistic Style is a reindenter and reformatter of C++, C and Java source code"
HOMEPAGE="http://astyle.sourceforge.net/"
SRC_URI="mirror://sourceforge/astyle/astyle_${PV}_linux.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"

IUSE="doc java static-libs"

DEPEND="app-arch/xz-utils
	java? ( >=virtual/jdk-1.6:= )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

pkg_setup() {
	java-pkg-opt-2_pkg_setup
	tc-export CXX
}

src_prepare() {
	eapply_user
	java-pkg-opt-2_src_prepare
	sed	-e "s:^\(JAVAINCS\s*\)=.*$:\1= $(java-pkg_get-jni-cflags):" \
		-e "s:ar crs:$(tc-getAR) crs:" \
		-i build/gcc/Makefile || die
}

src_compile() {
	emake -f ../build/gcc/Makefile -C src \
		${PN} \
		shared \
		$(usex java java '') \
		$(usex static-libs static '')
}

src_install() {
	insinto /usr/include
	doins src/${PN}.h

	pushd src/bin &> /dev/null
	dobin ${PN}

	dolib.so lib${P}.so
	dosym lib${P}.so /usr/$(get_libdir)/lib${PN}.so
	if use java ; then
		dolib.so lib${P}j.so
		dosym lib${P}j.so /usr/$(get_libdir)/lib${PN}j.so
	fi
	if use static-libs ; then
		dolib lib${PN}.a
	fi
	popd &> /dev/null

	use doc && dohtml doc/*
}
