# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{5,6} )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 gnome2-utils xdg-utils

MY_PN="Guake"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Drop-down terminal for GTK+ desktops"
HOMEPAGE="https://github.com/Guake/guake https://pypi.org/project/Guake"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="utempter"

RDEPEND="
	dev-libs/keybinder:3
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pbr[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	x11-libs/libnotify
	x11-libs/vte:2.91
	utempter? ( sys-libs/libutempter )"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	gnome-base/gsettings-desktop-schemas
	sys-devel/gettext
	sys-devel/make"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	distutils-r1_python_prepare_all
	emake prepare-install prefix=/usr
	emake generate-paths prefix=/usr DATA_DIR='$(datadir)/guake' DEV_SCHEMA_DIR='$(gsettingsschemadir)'
}

python_install_all() {
	emake install-schemas install-locale prefix=/usr DESTDIR="${D}"
	distutils-r1_python_install_all
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_desktop_database_update
}
