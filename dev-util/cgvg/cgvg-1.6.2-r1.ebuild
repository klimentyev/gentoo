# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A tiny version of cscope that is much more useful in certian instances"
HOMEPAGE="http://uzix.org/cgvg.html"
SRC_URI="http://uzix.org/cgvg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}"
