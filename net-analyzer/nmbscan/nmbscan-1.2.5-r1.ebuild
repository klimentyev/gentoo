# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="netbios scanner"
HOMEPAGE="http://nmbscan.gbarbier.org/"
SRC_URI="http://nmbscan.gbarbier.org/down/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"

RDEPEND="net-dns/bind-tools
	net-fs/samba
	net-misc/iputils
	sys-apps/net-tools
	virtual/awk"

S=${WORKDIR}
PATCHES=( "${FILESDIR}"/${P}-head.diff )

src_compile() { :; }

src_install() {
	dobin nmbscan
}
