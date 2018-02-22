# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

SCM=
[[ "${PV}" = 9999 ]] && SCM="autotools git-r3"
inherit flag-o-matic libtool multilib multilib-build multilib-minimal toolchain-funcs ${SCM}
unset SCM

INFINALITY_PATCH="03-infinality-2.6.3-2016.03.26.patch"

DESCRIPTION="A high-quality and portable font engine"
HOMEPAGE="https://www.freetype.org/"
IUSE="X +adobe-cff bindist bzip2 +cleartype_hinting debug fontforge harfbuzz
	infinality png static-libs utils"

if [[ "${PV}" != 9999 ]] ; then
	SRC_URI="mirror://sourceforge/freetype/${P/_/}.tar.bz2
		mirror://nongnu/freetype/${P/_/}.tar.bz2
		utils?	( mirror://sourceforge/freetype/ft2demos-${PV}.tar.bz2
			mirror://nongnu/freetype/ft2demos-${PV}.tar.bz2 )
		doc?	( mirror://sourceforge/freetype/${PN}-doc-${PV}.tar.bz2
			mirror://nongnu/freetype/${PN}-doc-${PV}.tar.bz2 )"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
	IUSE+="doc"
fi

LICENSE="|| ( FTL GPL-2+ )"
SLOT="2"
RESTRICT="!bindist? ( bindist )" # bug 541408

CDEPEND=">=sys-libs/zlib-1.2.8-r1[${MULTILIB_USEDEP}]
	bzip2? ( >=app-arch/bzip2-1.0.6-r4[${MULTILIB_USEDEP}] )
	harfbuzz? ( >=media-libs/harfbuzz-0.9.19[truetype,${MULTILIB_USEDEP}] )
	png? ( >=media-libs/libpng-1.2.51:0=[${MULTILIB_USEDEP}] )
	utils? (
		X? (
			>=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]
			>=x11-libs/libXau-1.0.7-r1[${MULTILIB_USEDEP}]
			>=x11-libs/libXdmcp-1.1.1-r1[${MULTILIB_USEDEP}]
		)
	)"
DEPEND="${CDEPEND}
	virtual/pkgconfig"
RDEPEND="${CDEPEND}"
PDEPEND="infinality? ( media-libs/fontconfig-infinality )"

PATCHES=(
	# This is the same as the 01 patch from infinality
	"${FILESDIR}"/${PN}-2.7-enable-valid.patch

	"${FILESDIR}"/${PN}-2.4.11-sizeof-types.patch # 459966
)

src_fetch() {
	if [[ "${PV}" = 9999 ]] ; then
		local EGIT_REPO_URI
		EGIT_REPO_URI="https://git.savannah.gnu.org/r/freetype/freetype2.git"
		git-r3_src_fetch
		if use utils ; then
			EGIT_REPO_URI="https://git.savannah.gnu.org/r/freetype/freetype2-demos.git"
			git-r3_src_fetch
		fi
	else
		default
	fi
}

src_unpack() {
	if [[ "${PV}" = 9999 ]] ; then
		local EGIT_REPO_URI
		EGIT_REPO_URI="http://git.savannah.gnu.org/r/freetype/freetype2.git"
		git-r3_src_unpack
		if use utils ; then
			EGIT_REPO_URI="http://git.savannah.gnu.org/r/freetype/freetype2-demos.git"
			local EGIT_CHECKOUT_DIR="${WORKDIR}/ft2demos-${PV}"
			git-r3_src_unpack
		fi
	else
		default
	fi
}

src_prepare() {
	if [[ "${PV}" = 9999 ]] ; then
		# inspired by shipped autogen.sh script
		eval $(sed -nf version.sed include/freetype/freetype.h)
		pushd builds/unix &>/dev/null || die
		sed -e "s;@VERSION@;$freetype_major$freetype_minor$freetype_patch;" \
			< configure.raw > configure.ac || die
		# eautoheader produces broken ftconfig.in
		eautoheader() { return 0 ; }
		AT_M4DIR="." eautoreconf
		unset freetype_major freetype_minor freetype_patch
		popd &>/dev/null || die
	fi

	default

	enable_option() {
		sed -i -e "/#define $1/ { s:/\* ::; s: \*/:: }" \
			include/${PN}/config/ftoption.h \
			|| die "unable to enable option $1"
	}

	disable_option() {
		sed -i -e "/#define $1/ { s:^:/* :; s:$: */: }" \
			include/${PN}/config/ftoption.h \
			|| die "unable to disable option $1"
	}

	# Will be the new default for >=freetype-2.7.0
	disable_option "TT_CONFIG_OPTION_SUBPIXEL_HINTING  2"

	if use infinality && use cleartype_hinting; then
		enable_option "TT_CONFIG_OPTION_SUBPIXEL_HINTING  ( 1 | 2 )"
	elif use infinality; then
		enable_option "TT_CONFIG_OPTION_SUBPIXEL_HINTING  1"
	elif use cleartype_hinting; then
		enable_option "TT_CONFIG_OPTION_SUBPIXEL_HINTING  2"
	fi

	# Can be disabled with FREETYPE_PROPERTIES="pcf:no-long-family-names=1"
	# via environment (new since v2.8)
	enable_option PCF_CONFIG_OPTION_LONG_FAMILY_NAMES

	if ! use bindist; then
		# See http://freetype.org/patents.html
		# ClearType is covered by several Microsoft patents in the US
		enable_option FT_CONFIG_OPTION_SUBPIXEL_RENDERING
	fi

	if ! use adobe-cff; then
		enable_option CFF_CONFIG_OPTION_OLD_ENGINE
	fi

	if use debug; then
		enable_option FT_DEBUG_LEVEL_TRACE
		enable_option FT_DEBUG_MEMORY
	fi

	if use utils; then
		cd "${WORKDIR}/ft2demos-${PV}" || die
		# Disable tests needing X11 when USE="-X". (bug #177597)
		if ! use X; then
			sed -i -e "/EXES\ +=\ ftdiff/ s:^:#:" Makefile || die
		fi
		cd "${S}" || die
	fi

	# we need non-/bin/sh to run configure
	if [[ -n ${CONFIG_SHELL} ]] ; then
		sed -i -e "1s:^#![[:space:]]*/bin/sh:#!$CONFIG_SHELL:" \
			"${S}"/builds/unix/configure || die
	fi

	elibtoolize --patch-only
}

multilib_src_configure() {
	append-flags -fno-strict-aliasing
	type -P gmake &> /dev/null && export GNUMAKE=gmake

	local myeconfargs=(
		--enable-biarch-config
		--enable-shared
		$(use_with bzip2)
		$(use_with harfbuzz)
		$(use_with png)
		$(use_enable static-libs static)

		# avoid using libpng-config
		LIBPNG_CFLAGS="$($(tc-getPKG_CONFIG) --cflags libpng)"
		LIBPNG_LDFLAGS="$($(tc-getPKG_CONFIG) --libs libpng)"
	)

	ECONF_SOURCE="${S}" \
		econf "${myeconfargs[@]}"
}

multilib_src_compile() {
	default

	if multilib_is_native_abi && use utils; then
		einfo "Building utils"
		# fix for Prefix, bug #339334
		emake \
			X11_PATH="${EPREFIX}/usr/$(get_libdir)" \
			FT2DEMOS=1 TOP_DIR_2="${WORKDIR}/ft2demos-${PV}"
	fi
}

multilib_src_install() {
	default

	if multilib_is_native_abi && use utils; then
		einfo "Installing utils"
		rm "${WORKDIR}"/ft2demos-${PV}/bin/README || die
		local ft2demo
		for ft2demo in ../ft2demos-${PV}/bin/*; do
			./libtool --mode=install $(type -P install) -m 755 "$ft2demo" \
				"${ED}"/usr/bin || die
		done
	fi
}

multilib_src_install_all() {
	if use fontforge; then
		# Probably fontforge needs less but this way makes things simplier...
		einfo "Installing internal headers required for fontforge"
		local header
		find src/truetype include/freetype/internal -name '*.h' | \
		while read header; do
			mkdir -p "${ED}/usr/include/freetype2/internal4fontforge/$(dirname ${header})" || die
			cp ${header} "${ED}/usr/include/freetype2/internal4fontforge/$(dirname ${header})" || die
		done
	fi

	dodoc docs/{CHANGES,CUSTOMIZE,DEBUG,INSTALL.UNIX,*.txt,PROBLEMS,TODO}
	if [[ "${PV}" != 9999 ]] && use doc ; then
		docinto html
		dodoc -r docs/*
	fi

	prune_libtool_files --all
}
