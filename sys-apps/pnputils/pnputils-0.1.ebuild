# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Plug and Play BIOS utilities"
HOMEPAGE="https://www.debian.org/"
SRC_URI="http://ftp.be.debian.org/pub/linux/kernel/people/helgaas/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=( "${FILESDIR}/${P}-makefile.patch" )

src_compile() {
	emake CC="$(tc-getCC)" all
}
