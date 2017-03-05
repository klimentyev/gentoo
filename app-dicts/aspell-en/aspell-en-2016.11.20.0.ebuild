# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

ASPELL_LANG="English (US, British, Canadian)"
ASPOSTFIX="6"

inherit aspell-dict versionator

LICENSE="myspell-en_CA-KevinAtkinson public-domain Princeton Ispell"

KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"

IUSE=""

SRC_URI="mirror://gnu/aspell/dict/${SPELLANG}/${PN%-*}${ASPOSTFIX}-${PN#*-}-$(replace_version_separator 3 '-').tar.bz2"
