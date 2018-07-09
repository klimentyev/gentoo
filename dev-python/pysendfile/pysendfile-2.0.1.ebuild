# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} pypy )

inherit distutils-r1

DESCRIPTION="A python interface to sendfile(2) system call"
HOMEPAGE="https://github.com/giampaolo/pysendfile"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="amd64 ~arm ia64 ppc64 ~sparc x86"
IUSE=""
LICENSE="MIT"
SLOT="0"

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

# Testsuite abandonned due to demanding starting a local web type server
