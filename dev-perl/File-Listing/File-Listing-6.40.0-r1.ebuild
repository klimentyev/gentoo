# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MODULE_AUTHOR=GAAS
MODULE_VERSION=6.04
inherit perl-module

DESCRIPTION="Parse directory listings"

SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="
	!<dev-perl/libwww-perl-6
	>=dev-perl/HTTP-Date-6.0.0
"
DEPEND="${RDEPEND}"

SRC_TEST=do
