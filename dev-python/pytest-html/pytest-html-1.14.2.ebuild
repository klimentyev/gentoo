# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{4,5,6} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="Plugin for generating HTML reports for py.test results"
HOMEPAGE="https://github.com/pytest-dev/pytest-html/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
# Lots of test failures...
RESTRICT="test"
RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/pytest-metadata[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]"

python_test() {
	PYTHONPATH=${PWD}${PYTHONPATH:+:}${PYTHONPATH} \
		py.test -v -r a testing/test_pytest_html.py || die
}
