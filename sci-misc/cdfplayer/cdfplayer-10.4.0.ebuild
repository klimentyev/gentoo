# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit versionator

DESCRIPTION="Wolfram Player for the interactive Computable Document Format (CDF)"
SRC_URI="CDFPlayer_10.4.0_LINUX.sh"
HOMEPAGE="http://www.wolfram.com/cdf-player/"

LICENSE="WolframCDFPlayer"
KEYWORDS="-* ~amd64 ~x86"
SLOT="0"
IUSE=""

RESTRICT="strip mirror bindist fetch"

DEPEND=""

# this list comes from lsof output
# probably there are still some libraries missing
RDEPEND="
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXcursor
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXmu
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXt
	media-libs/alsa-lib
	dev-libs/expat
	media-libs/fontconfig
	dev-libs/icu
	x11-libs/libxcb
	dev-libs/libxml2
	|| ( sys-libs/ncurses:5/5 sys-libs/ncurses:0/5 )
"

# we need this a few times
MPV=$(get_version_component_range 1-2)

# we might as well list all files in all QA variables...
QA_PREBUILT="opt/*"

S=${WORKDIR}

src_unpack() {
	/bin/sh "${DISTDIR}/${A}" --nox11 --confirm --keep -- -auto "-targetdir=${S}/opt/Wolfram/CDFPlayer/${MPV}" "-execdir=${S}/opt/bin" || die
}

src_install() {
	# move all over
	mv "${S}/opt" "${D}/opt" || die

	# the autogenerated symlinks point into sandbox, redo
	rm "${D}/opt/bin/"* || die
	dosym /opt/Wolfram/CDFPlayer/${MPV}/Executables/wolframcdfplayer opt/bin/wolframcdfplayer
	dosym /opt/Wolfram/CDFPlayer/${MPV}/Executables/WolframCDFPlayer opt/bin/WolframCDFPlayer

	# fix some embedded paths and install desktop files
	insinto /usr/share/applications
	for filename in $(find "${D}" -name "wolfram-cdf10.desktop") ; do
		echo Fixing "${filename}"
		sed -e "s:${S}::g" -e 's:^\t\t::g' -i "${filename}"
		echo "Categories=Physics;Science;Engineering;2DGraphics;Graphics;" >> "${filename}"
		doins "${filename}"
	done
}

pkg_nofetch() {
	einfo "Sadly Wolfram provides no permanent link to the player files."
	einfo "Please download the Wolfram CFD Player installation file ${SRC_URI} from"
	einfo "${HOMEPAGE} and place it in ${DISTDIR}"
}
