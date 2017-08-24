# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MY_P="converttexttonumber-${PV}"
OFFICE_EXTENSIONS=(
	"${MY_P}.oxt"
)
inherit office-ext-r1

DESCRIPTION="Extension for converting text to numbers"
HOMEPAGE="https://extensions.libreoffice.org/extensions/ct2n-convert-text-to-number-and-dates"
SRC_URI="https://extensions.libreoffice.org/extensions/ct2n-convert-text-to-number-and-dates/${PV}/@@download/file/${MY_P}.oxt"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
