# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

MY_PV=${PV/_beta/b}
MY_PV=${MY_PV/_rc/rc}
LPV=${MY_PV}
MY_P=${PN}-${MY_PV}

DESCRIPTION="A high level interface to all commonly used Bazaar features"
HOMEPAGE="https://launchpad.net/bzr-explorer"
SRC_URI="https://launchpad.net/${PN}/1.3/${LPV}/+download/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="amd64 x86"
IUSE="gtk"

DEPEND=""
RDEPEND=">=dev-vcs/bzr-2.5[${PYTHON_USEDEP}]
		>=dev-vcs/qbzr-0.23[${PYTHON_USEDEP}]
		gtk? ( dev-vcs/bzr-gtk[${PYTHON_USEDEP}] )"

pkg_setup() {
	python-single-r1_pkg_setup
}
