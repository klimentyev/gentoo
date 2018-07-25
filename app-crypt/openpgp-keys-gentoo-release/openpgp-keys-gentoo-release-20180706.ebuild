# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="OpenPGP keys used for Gentoo releases (snapshots, stages)"
HOMEPAGE="https://www.gentoo.org/downloads/signatures/"
SRC_URI="https://dev.gentoo.org/~mgorny/dist/openpgp-keys/gentoo-release.asc.${PV}.gz
	test? ( https://dev.gentoo.org/~mgorny/dist/openpgp-keys/gentoo-release-test-sigs-${PV}.tar.gz )"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE="test"

DEPEND="test? ( app-crypt/gnupg )"

S=${WORKDIR}

src_test() {
	local old_umask=$(umask)
	umask 077

	local -x GNUPGHOME=${T}/.gnupg
	mkdir "${GNUPGHOME}" || die
	einfo "Importing keys ..."
	gpg --import "gentoo-release.asc.${PV}" || die "Key import failed"

	local f
	for f in gentoo-release-test-sigs*/*.asc; do
		einfo "Testing ${f##*/} ..."
		gpg -q --trust-model always --verify "${f}" || die "Verification failed on ${f}"
	done

	umask "${old_umask}"
}

src_install() {
	insinto /usr/share/openpgp-keys
	newins "gentoo-release.asc.${PV}" gentoo-release.asc
}
