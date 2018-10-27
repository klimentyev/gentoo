# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="5eeb151a748788666534d6ea3da07f90400d24c2"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Decode EDID data in a human-readable format"
HOMEPAGE="https://git.linuxtv.org/edid-decode.git/"
SRC_URI="https://git.linuxtv.org/${PN}.git/snapshot/${MY_P}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${MY_P}"

src_install() {
	default

	insinto /usr/share/edid-decode
	doins data/*
}
