# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A curses terminal client for the Notmuch email system"
HOMEPAGE="https://github.com/wangp/bower"
SRC_URI="https://github.com/wangp/bower/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="app-crypt/gpgme:=
	>=dev-lang/mercury-11.07"
RDEPEND="app-crypt/gpgme:=
	net-mail/notmuch
	sys-apps/coreutils
	sys-libs/ncurses"

src_install() {
	dobin bower
	dodoc AUTHORS NEWS README.md bower.conf.sample
}
