# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils

DESCRIPTION="TLS Lite is a free python library that implements SSL 3.0 and TLS 1.0/1.1"
HOMEPAGE="http://trevp.net/tlslite/ https://pypi.python.org/pypi/tlslite https://github.com/trevp/tlslite"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
#Refrain for now setting IUSE test and deps of test given test restricted.
IUSE="doc gmp"
RESTRICT="test"

DEPEND=""
RDEPEND="${DEPEND}"

# Tests still hang
python_test() {
	"${S}"/tests/tlstest.py client localhost:4443 .
	"${S}"/tests/tlstest.py server localhost:4442 .
}

python_install_all(){
	distutils-r1_python_install_all
	use doc && dohtml -r docs/
}
