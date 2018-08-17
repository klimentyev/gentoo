# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{4..7} )

inherit distutils-r1

DESCRIPTION="Easy, clean, reliable Python 2/3 compatibility"
HOMEPAGE="http://python-future.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-fbsd ~amd64-linux ~x86-linux"
IUSE="test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}/${P}-disable-tests-with-internet-connection.patch"
	"${FILESDIR}/${P}-remove-typeerror-failure.patch"
)

python_test() {
	# Errors between py2 and py3
	rm -f tests/test_future/test_httplib.py || die "Removing test_httplib.py failed."
	rm -f tests/test_future/test_urllib_response.py || die "Removing  test_urllib_response.py failed."

	py.test -v || die "Tests failed under ${EPYTHON}"
}
