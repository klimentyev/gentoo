# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Electronic Schematic and PCB design tools GUI translations."
HOMEPAGE="https://github.com/KiCad/kicad-i18n"
SRC_URI="https://github.com/KiCad/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE=""

DEPEND="sys-devel/gettext"
RDEPEND=">=sci-electronics/kicad-5.0.0"
