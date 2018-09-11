# Copyright 2001-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN=github.com/docker/docker-credential-helpers

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64"
	EGIT_COMMIT="v${PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="A suite of programs to use native stores to keep Docker credentials safe"
HOMEPAGE="https://github.com/docker/docker-credential-helpers"
LICENSE="MIT"
SLOT="0"
RESTRICT="test"

IUSE="hardened libsecret pass"

DEPEND="libsecret? ( app-crypt/libsecret )"

RDEPEND="|| (
	$DEPEND
	pass? ( app-admin/pass )
)
"

S=${WORKDIR}/${P}/src/${EGO_PN}

src_compile() {
	if use libsecret; then
		CGO_LDFLAGS="$(usex hardened '-fno-PIC ' '')" GOPATH="${WORKDIR}/${P}" emake secretservice || die
	fi
	CGO_LDFLAGS="$(usex hardened '-fno-PIC ' '')" GOPATH="${WORKDIR}/${P}" emake pass || die
}

src_install() {
	dobin bin/*
	dodoc CHANGELOG.md MAINTAINERS README.md
}

pkg_postinst() {
	elog "You will need to add:"
	elog
	elog '"credStore": "secretservice"'
	elog
	elog "or"
	elog
	elog '"credStore": "pass"'
	elog
	elog "to your ~/.docker/config.json"
	elog
	elog "The first is to use kwallet/gnome-keyring, the second is to use 'pass'."
}
