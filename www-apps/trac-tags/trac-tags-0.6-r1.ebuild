# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_REV="9901"
MY_DIR="tagsplugin/tags/${PV}"

DESCRIPTION="Tags plugin for Trac"
HOMEPAGE="http://trac-hacks.org/wiki/TagsPlugin"
SRC_URI="http://trac-hacks.org/changeset/${MY_REV}/${MY_DIR}?old_path=%2F&format=zip
	-> ${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND=">=dev-python/genshi-0.6[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	app-arch/unzip"
RDEPEND="${CDEPEND}
	>=www-apps/trac-0.11[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_DIR}"
