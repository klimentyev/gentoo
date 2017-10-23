# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit toolchain-funcs eutils flag-o-matic

MY_PV=${PV//./}
DESCRIPTION="A very powerful editor for programmers"
HOMEPAGE="http://www.scintilla.org/SciTE.html"
SRC_URI="mirror://sourceforge/scintilla/${PN}${MY_PV}.tgz"

LICENSE="HPND lua? ( MIT )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~arm-linux ~x86-linux"
IUSE="lua"

RDEPEND="dev-libs/glib:=
	x11-libs/cairo
	x11-libs/gtk+:3=
	x11-libs/gdk-pixbuf
	x11-libs/pango
	lua? ( >=dev-lang/lua-5:= )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${PN}/gtk"

src_prepare() {
	sed -i "${WORKDIR}/scintilla/gtk/makefile" \
		-e "s#^CXXFLAGS=#CXXFLAGS=${CXXFLAGS} #" \
		-e "s#^\(CXXFLAGS=.*\)-Os#\1#" \
		-e "s#^CC =\(.*\)#CC = $(tc-getCXX)#" \
		-e "s#^CCOMP =\(.*\)#CCOMP = $(tc-getCC)#" \
		-e "s#-Os##" \
		|| die "error patching /scintilla/gtk/makefile"

	sed -i "${WORKDIR}/scite/gtk/makefile" \
		-e "s#-rdynamic#-rdynamic ${LDFLAGS}#" \
		|| die "error patching /scite/gtk/makefile"

	#  add the ebuild suffix as shell type for working with ebuilds
	sed -i "${WORKDIR}/scite/src/perl.properties" \
		-e "s#\*.sh;\*.bsh;#\*.ebuild;\*.sh;\*.bsh;#" \
		|| die "error patching /scite/src/perl.prperties"

	# repair and enhance the .desktop file
	sed -i "${WORKDIR}/scite/gtk/SciTE.desktop" \
		-e "s/^Encoding/#Encoding/" \
		-e "s#text/plain#text/\*;application/xhtml+xml#" \
		-e "s#^Categories=\(.*\)#Categories=Development;#" \
		|| die "error patching /scite/gtk/SciTe.desktop"

	sed -i "${S}/makefile" \
		-e 's#usr/local#usr#g' \
		-e 's#/gnome/apps/Applications#/applications#' \
		-e "s#^CXXFLAGS=#CXXFLAGS=${CXXFLAGS} #" \
		-e "s#^\(CXXFLAGS=.*\)-Os#\1#" \
		-e "s#^CC =\(.*\)#CC = $(tc-getCXX)#" \
		-e "s#^CCOMP =\(.*\)#CCOMP = $(tc-getCC)#" \
		-e 's#${D}##' \
		-e 's#-g root#-g 0#' \
		-e "s#-Os##" \
		|| die "error patching gtk/makefile"

	# it seems that pwd here is ${S}, but user patches are relative to ${workdir}
	# Bug #576162
	cd "${WORKDIR}"
	eapply_user
}

src_compile() {
	# prepare make options
	emake_pars="GTK3=1"
	if ! use lua; then
		emake_pars+=" NO_LUA=1"
	fi;

	emake CC="$(tc-getCC)" LD="$(tc-getLD)" \
			LDFLAGS="$(raw-ldflags)" AR="$(tc-getAR)" \
			-C "${WORKDIR}/scintilla/gtk" $emake_pars
	emake $emake_pars
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/{pixmaps,applications}

	emake DESTDIR="${ED}" install

	# we have to keep this because otherwise it'll break upgrading
	mv "${ED}/usr/bin/SciTE" "${ED}/usr/bin/scite" || die
	dosym /usr/bin/scite /usr/bin/SciTE

	doman ../doc/scite.1
	dodoc ../README
}
