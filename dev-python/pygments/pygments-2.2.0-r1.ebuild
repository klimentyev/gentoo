# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} pypy pypy3 )

inherit distutils-r1 bash-completion-r1

MY_PN="Pygments"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Pygments is a syntax highlighting package written in Python"
HOMEPAGE="http://pygments.org/ https://pypi.org/project/Pygments/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x64-cygwin ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="doc test"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		virtual/ttf-fonts )"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	# fix generators for python3.7+
	"${FILESDIR}"/pygments-2.2.0-pep479.patch
	# Fixing USE="doc" with sphinx1.7+. bug #662640
	"${FILESDIR}"/pygments-2.2.0-sphinx17.patch
)

python_compile_all() {
	use doc && emake -C doc html
}

python_test() {
	cp -r -l tests "${BUILD_DIR}"/ || die
	# With pypy3 there is 1 error out of 1556 tests when run as is and
	# (SKIP=8, errors=1, failures=1) when run with 2to3; meh
	nosetests --verbosity=3 -w "${BUILD_DIR}"/tests \
		|| die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/_build/html/. )

	distutils-r1_python_install_all
	newbashcomp external/pygments.bashcomp pygmentize
}
