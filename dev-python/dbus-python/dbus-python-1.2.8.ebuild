# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} )
PYTHON_REQ_USE="threads(+)"

inherit autotools python-r1

DESCRIPTION="Python bindings for the D-Bus messagebus"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/DBusBindings https://dbus.freedesktop.org/doc/dbus-python/"
SRC_URI="https://dbus.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd"
IUSE="doc examples test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

RDEPEND="
	>=sys-apps/dbus-1.8:=
	>=dev-libs/glib-2.40
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( $(python_gen_any_dep 'dev-python/sphinx[${PYTHON_USEDEP}]') )
	test? ( dev-python/pygobject:3[${PYTHON_USEDEP}]
		dev-python/tappy[${PYTHON_USEDEP}] )"

python_check_deps() {
	has_version "dev-python/sphinx[${PYTHON_USEDEP}]"
}

src_prepare() {
	default
	# Update py-compile, bug 529502.
	eautoreconf
	python_copy_sources
}

src_configure() {
	use doc && python_setup
	local SPHINX_IMPL=${EPYTHON}

	configuring() {
		local myconf=(
			--disable-documentation
		)
		[[ ${EPYTHON} == ${SPHINX_IMPL} ]] &&
			myconf+=( --enable-documentation )

		econf "${myconf[@]}"
	}
	python_foreach_impl run_in_build_dir configuring
}

src_compile() {
	python_foreach_impl run_in_build_dir default
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	python_foreach_impl run_in_build_dir default
}

src_install() {
	python_foreach_impl run_in_build_dir default
	find "${D}" -name "*.la" -delete || die

	use examples && dodoc -r examples
}
