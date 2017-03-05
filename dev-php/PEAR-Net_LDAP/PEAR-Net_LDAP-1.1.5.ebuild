# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit php-pear-r1

KEYWORDS="amd64 hppa ppc x86"

DESCRIPTION="OO interface for searching and manipulating LDAP-entries"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/php[ldap]"
