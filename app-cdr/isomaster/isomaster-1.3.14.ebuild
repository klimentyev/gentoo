# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils xdg-utils toolchain-funcs

DESCRIPTION="Graphical CD image editor for reading, modifying and writing ISO images"
HOMEPAGE="http://littlesvr.ca/isomaster"
SRC_URI="http://littlesvr.ca/${PN}/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="nls"

RDEPEND=">=dev-libs/iniparser-4.1:4
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( >=sys-devel/gettext-0.19.1 )"  # bug 512448

pkg_setup() {
	myisoconf=(
		DEFAULT_EDITOR=leafpad
		MYDOCPATH=/usr/share/doc/${PF}/bkisofs
		USE_SYSTEM_INIPARSER=1
		LIB_INIPARSER=iniparser4
		PREFIX=/usr
		)

	use nls || myisoconf+=( WITHOUT_NLS=1 )
}

src_prepare() {
	rm -R iniparser-4.1 || die
	eapply_user
}

src_configure() { :; } #274361

src_compile() {
	tc-export CC
	emake "${myisoconf[@]}"
}

_apply_linguas() {
	mv "${D}"/usr/share/locale{,_ALL} || die
	dodir /usr/share/locale || die
	for lingua in ${LINGUAS}; do
		[[ -d "${D}"/usr/share/locale_ALL/${lingua} ]] || break
		mv "${D}"/usr/share/{locale_ALL/${lingua},locale/} || die
	done
	rm -R "${D}"/usr/share/locale_ALL || die
}

src_install() {
	emake "${myisoconf[@]}" DESTDIR="${D}" install
	dodoc {CHANGELOG,CREDITS,README,TODO}.TXT *.txt

	use nls && _apply_linguas  # bug 402679, bug 512448
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
