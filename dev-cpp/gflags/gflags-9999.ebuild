# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-multilib

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gflags/gflags.git"
else
	SRC_URI="https://github.com/gflags/gflags/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux"
fi

DESCRIPTION="Google's C++ argument parsing library"
HOMEPAGE="http://gflags.github.io/gflags/"

LICENSE="BSD"
SLOT="0"
IUSE="static-libs"

# AUTHORS.txt only links the google group
DOCS=( ChangeLog.txt README.md )

multilib_src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_STATIC_LIBS=$(usex static-libs)
	)
	cmake-utils_src_configure
}
