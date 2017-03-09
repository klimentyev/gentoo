# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils

DESCRIPTION="C library for the MaxMind DB file format"
HOMEPAGE="https://github.com/maxmind/libmaxminddb"
SRC_URI="${HOMEPAGE}/releases/download/${PV}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/0.0.7"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

DOCS=( Changes.md )

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default

	prune_libtool_files
}
