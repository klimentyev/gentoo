# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{4,5,6} )

inherit bash-completion-r1 distutils-r1

DESCRIPTION="Powerful command-line bookmark manager"
HOMEPAGE="https://github.com/jarun/Buku"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jarun/Buku"
else
	# Tests are not working with the pypi version (https://github.com/jarun/Buku/issues/325)
	SRC_URI="https://github.com/jarun/Buku/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	# SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz -> ${P}.tar.gz"

	# Github folder name starts with capital B
	S="${WORKDIR}/Buku-${PV}"

	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="test"

RDEPEND="
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.13.1[${PYTHON_USEDEP}]

	dev-python/arrow[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/flask-admin[${PYTHON_USEDEP}]
	dev-python/flask-api[${PYTHON_USEDEP}]
	dev-python/flask-bootstrap[${PYTHON_USEDEP}]
	dev-python/flask-paginate[${PYTHON_USEDEP}]
	dev-python/flask-wtf[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}
	test? (
		dev-python/attrs[${PYTHON_USEDEP}]
		dev-python/flake8[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/py[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/vcrpy[${PYTHON_USEDEP}]
	)
"

python_install_all() {
	distutils-r1_python_install_all

	insinto /usr/share/zsh/site-functions
	doins auto-completion/zsh/_*

	newbashcomp auto-completion/bash/buku-completion.bash "${PN}"

	doman buku.1
}

python_test() {
	py.test -vv tests/test_* || die
}
