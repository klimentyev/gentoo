# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs multiprocessing

MYP=${PN}-gpl-${PV}

DESCRIPTION="Multi-Language Management"
HOMEPAGE="http://libre.adacore.com/"
SRC_URI="
	http://mirrors.cdn.adacore.com/art/591c45e2c7a447af2deecff7
		-> ${MYP}-src.tar.gz
	bootstrap? (
		http://mirrors.cdn.adacore.com/art/591aeb88c7a4473fcbb154f8
		-> xmlada-gpl-${PV}-src.tar.gz )"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bootstrap +shared static static-pic"

DEPEND="dev-lang/gnat-gpl:=
	!bootstrap? ( dev-ada/xmlada[static] )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${MYP}-src

REQUIRED_USE="bootstrap? ( !shared !static !static-pic )"
PATCHES=( "${FILESDIR}"/${P}-gentoo.patch )

pkg_setup() {
	if use bootstrap; then
		GCC=${ADA:-$(tc-getCC)}
		gnatbase=$(basename ${GCC})
		gnatpath=$(dirname ${GCC})

		GNATMAKE="${gnatbase/gcc/gnatmake}"
		if [[ ${gnatpath} != "." ]] ; then
			GNATMAKE="${gnatpath}/${GNATMAKE}"
		fi

		if [[ -z "$(type ${GNATMAKE} 2>/dev/null)" ]] ; then
			eerror "You need a gcc compiler that provides the Ada Compiler:"
			eerror "1) use gcc-config to select the right compiler or"
			eerror "2) set ADA in make.conf"
			die "ada compiler not available"
		fi
	fi
}

src_prepare() {
	gnatbase=$(basename ${GCC})
	GCC_PV=${gnatbase#*gcc-}
	sed -e "s:@VER@:${GCC_PV}:g" "${FILESDIR}"/${P}.xml > gnat-${GCC_PV}.xml
	default
}

src_configure() {
	emake prefix="${D}"usr setup
}

bin_progs="gprbuild gprconfig gprclean gprinstall gprname gprls"
lib_progs="gprlib gprbind"

src_compile() {
	if use bootstrap; then
		local xmlada_src="../xmlada-gpl-${PV}-src"
		incflags="-Isrc -Igpr/src -I${xmlada_src}/sax -I${xmlada_src}/dom \
			-I${xmlada_src}/schema -I${xmlada_src}/unicode \
			-I${xmlada_src}/input_sources"
		${GCC} -c ${CFLAGS} gpr/src/gpr_imports.c -o gpr_imports.o || die
		for bin in ${bin_progs}; do
			${GNATMAKE} -j$(makeopts_jobs) ${incflags} $ADAFLAGS ${bin}-main \
				-o ${bin} -largs gpr_imports.o || die
		done
		for lib in $lib_progs; do
			${GNATMAKE} -j$(makeopts_jobs) ${incflags} ${lib} $ADAFLAGS \
				-largs gpr_imports.o || die
		done
	else
		gprbuild -p -m -j$(makeopts_jobs) -XBUILD=production -v \
			gprbuild.gpr -XLIBRARY_TYPE=static -XXMLADA_BUILD=static \
			-cargs:C ${CFLAGS} -cargs:Ada ${ADAFLAGS} || die
		if use shared; then
			gprbuild -p -m -j$(makeopts_jobs) -XBUILD=production -v \
				-XLIBRARY_TYPE=relocatable -XXMLADA_BUILD=relocatable \
				gpr/gpr.gpr -cargs:C ${CFLAGS} -cargs:Ada ${ADAFLAGS} || die
		fi
		for kind in static static-pic; do
			if use ${kind}; then
				gprbuild -p -m -j$(makeopts_jobs) -XBUILD=production -v \
					-XLIBRARY_TYPE=${kind} -XXMLADA_BUILD=${kind} gpr/gpr.gpr \
					-cargs:C ${CFLAGS} -cargs:Ada ${ADAFLAGS} || die
			fi
		done
	fi
}

src_install() {
	if use bootstrap; then
		dobin ${bin_progs}
		exeinto /usr/libexec/gprbuild
		doexe ${lib_progs}
		insinto /usr/share/gprconfig
		doins share/gprconfig/*
		insinto /usr/share/gpr
		doins share/_default.gpr
	else
		default
		for kind in shared static static-pic; do
			if use ${kind}; then
				emake DESTDIR="${D}" libgpr.install.${kind}
			fi
		done
		rm "${D}"usr/doinstall || die
	fi
	insinto /usr/share/gprconfig
	doins gnat-${GCC_PV}.xml
	einstalldocs
}
