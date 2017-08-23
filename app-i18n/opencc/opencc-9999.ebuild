# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-utils

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/BYVoid/OpenCC"
else
	inherit vcs-snapshot

	SRC_URI="https://github.com/BYVoid/${PN^^[oc]}/archive/ver.${PV}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Libraries for conversion between Traditional and Simplified Chinese"
HOMEPAGE="https://github.com/BYVoid/OpenCC"

LICENSE="Apache-2.0"
SLOT="0/2"
KEYWORDS=""
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"

DOCS="AUTHORS *.md"

src_prepare() {
	sed -i "s|\${DIR_SHARE_OPENCC}/doc|share/doc/${PF}|" doc/CMakeLists.txt

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_DOCUMENTATION=$(usex doc)
		-DBUILD_SHARED_LIBS=ON
		-DENABLE_GTEST=OFF
	)
	cmake-utils_src_configure
}
