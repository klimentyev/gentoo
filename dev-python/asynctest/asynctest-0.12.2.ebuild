# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit distutils-r1

DESCRIPTION="Enhance the standard unittest with features for testing asyncio libraries"
HOMEPAGE="https://github.com/Martiusweb/asynctest/ https://pypi.org/project/asynctest/"
SRC_URI="https://github.com/Martiusweb/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/disable-failing-tests.patch" )

python_test() {
	"${EPYTHON}" -m unittest test || die "Testing failed"
}
