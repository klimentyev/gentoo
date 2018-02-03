# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib linux-info

DESCRIPTION="Best-Effort Extent-Same, a btrfs dedup agent"
HOMEPAGE="https://github.com/Zygo/bees"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/kakra/bees.git"
	EGIT_BRANCH="integration"
	inherit git-r3
else
	SRC_URI="https://github.com/Zygo/bees/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

PATCHES=(
	"${FILESDIR}/v0.5-0001-Gentoo-Remove-building-README.html.patch"
	"${FILESDIR}/v0.5-0002-Gentoo-use-system-provided-cflags.patch"
)

LICENSE="GPL-3"
SLOT="0"
IUSE="tools test"

RDEPEND=">=sys-apps/util-linux-2.30.2"
DEPEND="$RDEPEND >=sys-fs/btrfs-progs-4.1"

DOCS="README.md COPYING"

pkg_pretend() {
	if [[ ${MERGE_TYPE} != buildonly ]]; then
		if kernel_is -lt 4 4 3; then
			ewarn "Kernel versions below 4.4.3 lack support for bees, it won't work."
		fi
		if kernel_is -lt 4 11; then
			ewarn "With kernel versions below 4.11, bees may severely degrade system performance"
			ewarn "and responsiveness. Especially, the kernel may deadlock while bees is"
			ewarn "running, it's recommended to run at least kernel 4.11."
		fi
		elog "Bees recommends to run the latest current kernel for performance and"
		elog "reliability reasons, see README.md."
	fi
}

src_configure() {
	cat >localconf <<-EOF || die
		LIBEXEC_PREFIX=/usr/libexec
		LIBDIR=$(get_libdir)
		DEFAULT_MAKE_TARGET=all
	EOF
	use tools && echo OPTIONAL_INSTALL_TARGETS=install_tools >>localconf || die
}
