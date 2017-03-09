# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4} )

inherit distutils-r1

DESCRIPTION="Python tools to manipulate graphs and complex networks"
HOMEPAGE="http://networkx.github.io/ https://github.com/networkx/networkx"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc examples test"

COMMON_DEPEND="dev-python/matplotlib[${PYTHON_USEDEP}]
		sci-libs/scipy[${PYTHON_USEDEP}]"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		$(python_gen_cond_dep 'dev-python/numpydoc[${PYTHON_USEDEP}]' python2_7)
		$(python_gen_cond_dep 'dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}]' python2_7 python{3_3,3_4})
	)
	test? (
		${COMMON_DEPEND}
		dev-python/nose[${PYTHON_USEDEP}]
	)"
RDEPEND="
	>=dev-python/decorator-3.4.0[${PYTHON_USEDEP}]
	examples? (
		${COMMON_DEPEND}
		$(python_gen_cond_dep 'dev-python/pygraphviz[${PYTHON_USEDEP}]' python2_7)
		dev-python/pyparsing[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
	)"

python_prepare_all() {
	# Avoid d'loading of file objects.inv from 2 sites of python docs
	sed -e "s/'sphinx.ext.intersphinx', //" -i doc/source/conf.py || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	# https://github.com/networkx/networkx/issues/1263
	if use doc; then
		sed \
			-e "s:^\t\./:\t${PYTHON} :g" \
			-i doc/Makefile || die
		emake -C doc html
	fi
}

python_test() {
	nosetests -vv || die
}

python_install_all() {
	# Oh my.
	rm -r "${ED}"usr/share/doc/${P} || die

	use doc && local HTML_DOCS=( doc/build/html/. )
	use examples && local EXAMPLES=( examples/. )

	distutils-r1_python_install_all
}
