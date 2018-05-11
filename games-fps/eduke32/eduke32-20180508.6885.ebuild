# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit desktop eapi7-ver gnome2-utils toolchain-funcs

MY_BUILD="$(ver_cut 2)"
MY_DATE="$(ver_cut 1)"

MY_PN_HRP="duke3d_hrp"
MY_PN_OPL="duke3d_musopl"
MY_PN_PSX="duke3d_psx"
MY_PN_SC55="duke3d_music-sc55"
MY_PN_XXX="duke3d_xxx"

MY_PV_HRP="5.4"
MY_PV_OPL="2.01"
MY_PV_PSX="1.11"
MY_PV_SC55="4.02"
MY_PV_XXX="1.33"

DESCRIPTION="An open source engine port of the classic PC first person shooter Duke Nukem 3D"
HOMEPAGE="http://www.eduke32.com/"
SRC_URI="http://dukeworld.com/eduke32/synthesis/${MY_DATE}-${MY_BUILD}/${PN}_src_${MY_DATE}-${MY_BUILD}.tar.xz
	http://www.eduke32.com/images/eduke32_classic.png
	hrp? ( http://www.duke4.org/files/nightfright/hrp/duke3d_hrp.zip -> ${MY_PN_HRP}-${MY_PV_HRP}.zip )
	offensive? ( http://www.duke4.org/files/nightfright/related/${MY_PN_XXX}.zip -> ${MY_PN_XXX}-${MY_PV_XXX}.zip )
	opl? ( http://www.moddb.com/downloads/mirror/95750/102/ce9e8f422c6cccdb297852426e96740a -> ${MY_PN_OPL}-${MY_PV_OPL}.zip )
	psx? ( http://www.duke4.org/files/nightfright/related/duke3d_psx.zip -> ${MY_PN_PSX}-${MY_PV_PSX}.zip )
	sc-55? ( http://www.duke4.org/files/nightfright/music/${MY_PN_SC55}.zip -> ${MY_PN_SC55}-${MY_PV_SC55}.zip )"

KEYWORDS="~amd64 ~x86"
LICENSE="BUILDLIC GPL-2 HRP"
SLOT="0"
IUSE="cdinstall demo flac fluidsynth gtk hrp offensive opengl opl png psx sc-55 server sdk timidity tools vorbis vpx xmp"
REQUIRED_USE="cdinstall? ( !demo )
	demo? ( !cdinstall )
	hrp? ( ^^ ( demo cdinstall ) )
	offensive? ( ^^ ( demo cdinstall ) )
	opl? ( ^^ ( demo cdinstall )
		!sc-55 )
	psx? ( ^^ ( demo cdinstall ) )
	sc-55? ( ^^ ( demo cdinstall )
		!opl )
	vpx? ( opengl )"

S="${WORKDIR}/${PN}_${MY_DATE}-${MY_BUILD}"

MY_DEPEND_RDEPEND="media-libs/libsdl2[joystick,opengl?,sound,video,X]
	media-libs/sdl2-mixer[flac?,fluidsynth?,midi,timidity?,vorbis?]
	sys-libs/zlib:=
	flac? ( media-libs/flac )
		gtk? ( x11-libs/gtk+:2 )
	opengl? ( virtual/glu
		virtual/opengl )
	png? ( media-libs/libpng:0= )
	timidity? ( media-sound/timidity-freepats )
	vpx? ( media-libs/libvpx:= )
	vorbis? ( media-libs/libogg
		media-libs/libvorbis )
	xmp? ( media-libs/exempi:= )"

RDEPEND="${MY_DEPEND_RDEPEND}
	cdinstall? ( games-fps/duke3d-data )
	demo? ( games-fps/duke3d-demodata )"

DEPEND="${MY_DEPEND_RDEPEND}
	app-arch/unzip
	x86? ( dev-lang/nasm )"

PATCHES=( "${FILESDIR}/fix-build-transpal.patch" "${FILESDIR}/log-to-tmpdir.patch" "${FILESDIR}/search-duke3d-path.patch" )

src_unpack() {
	# Extract only the eduke32 archive
	unpack ${PN}_src_${MY_DATE}-${MY_BUILD}.tar.xz

	# Unpack only the documentation
	if use hrp; then
		unzip -q "${DISTDIR}"/${MY_PN_HRP}-${MY_PV_HRP}.zip hrp_readme.txt hrp_todo.txt || die
	fi
	if use offensive; then
		unzip -q "${DISTDIR}"/${MY_PN_XXX}-${MY_PV_XXX}.zip xxx_readme.txt || die
	fi
	if use opl; then
		unzip -q "${DISTDIR}"/${MY_PN_OPL}-${MY_PV_OPL}.zip readme.txt || die
	fi
	if use sc-55; then
		unzip -q "${DISTDIR}"/${MY_PN_SC55}-${MY_PV_SC55}.zip readme/music_readme.txt || die
	fi
}

src_compile() {
	local myemakeopts=(
		ALLOCACHE_AS_MALLOC=0
		AS=$(tc-getAS)
		CC=$(tc-getCC)
		CLANG=0
		CPLUSPLUS=1
		CUSTOMOPT=""
		DEBUGANYWAY=0
		F_JUMP_TABLES=""
		FORCEDEBUG=0
		HAVE_FLAC=$(usex flac 1 0)
		HAVE_GTK2=$(usex gtk 1 0)
		HAVE_VORBIS=$(usex vorbis 1 0)
		HAVE_XMP=$(usex xmp 1 0)
		LINKED_GTK=$(usex gtk 1 0)
		LTO=1
		LUNATIC=0
		KRANDDEBUG=0
		MEMMAP=0
		MIXERTYPE=SDL
		NETCODE=$(usex server 1 0)
		NOASM=0
		OPTLEVEL=0
		OPTOPT=""
		PACKAGE_REPOSITORY=1
		POLYMER=$(usex opengl 1 0)
		PRETTY_OUTPUT=0
		PROFILER=0
		RELEASE=1
		RENDERTYPE=SDL
		SDL_TARGET=2
		SIMPLE_MENU=0
		STRIP=""
		TANDALONE=0
		STARTUP_WINDOW=$(usex gtk 1 0)
		USE_OPENGL=$(usex opengl 1 0)
		USE_LIBVPX=$(usex vpx 1 0)
		USE_LIBPNG=$(usex png 1 0)
		USE_LUAJIT_2_1=0
		WITHOUT_GTK=$(usex gtk 0 1)
	)

	emake "${myemakeopts[@]}"

	if use tools; then
		emake utils "${myemakeopts[@]}"
	fi
}

src_install() {
	local binary
	local binaries=(
		eduke32
		mapster32
		"${FILESDIR}"/eduke32-bin
	)
	for binary in "${binaries[@]}"; do
		dobin "${binary}"
	done

	if use tools; then
		local tool
		local tools=(
			arttool
			bsuite
			cacheinfo
			generateicon
			givedepth
			ivfrate
			kextract
			kgroup
			kmd2tool
			makesdlkeytrans
			map2stl
			md2tool
			mkpalette
			transpal
			unpackssi
			wad2art
			wad2map
		)
		for tool in "${tools[@]}"; do
			dobin ${tool}
		done
	fi

	keepdir /usr/share/games/eduke32
	insinto /usr/share/games/eduke32
	if use hrp; then
		doins "${DISTDIR}"/${MY_PN_HRP}-${MY_PV_HRP}.zip
	fi
	if use offensive; then
		doins "${DISTDIR}"/${MY_PN_XXX}-${MY_PV_XXX}.zip
	fi
	if use opl; then
		doins "${DISTDIR}"/${MY_PN_OPL}-${MY_PV_OPL}.zip
	fi
	if use psx; then
		doins "${DISTDIR}"/${MY_PN_PSX}-${MY_PV_PSX}.zip
	fi
	if use sc-55; then
		doins "${DISTDIR}"/${MY_PN_SC55}-${MY_PV_SC55}.zip
	fi
	if use sdk; then
		doins -r package/sdk
	fi

	newicon "${DISTDIR}"/eduke32_classic.png eduke32.png

	make_desktop_entry eduke32-bin EDuke32 eduke32 Game
	make_desktop_entry mapster32 Mapster32 eduke32 Game

	local DOCS=( package/sdk/samples/*.txt source/build/doc/*.txt source/duke3d/src/lunatic/doc/*.txt )
	if use hrp; then
		DOCS+=( "${WORKDIR}"/hrp_readme.txt "${WORKDIR}"/hrp_todo.txt )
	fi
	if use offensive; then
		DOCS+=( "${WORKDIR}"/xxx_readme.txt )
	fi
	if use opl; then
		DOCS+=( "${WORKDIR}"/readme.txt )
	fi
	if use sc-55; then
		DOCS+=( "${WORKDIR}"/readme/music_readme.txt )
	fi
	einstalldocs
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
