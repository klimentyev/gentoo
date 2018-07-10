# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs

DESCRIPTION="X.Org X servers"
HOMEPAGE="https://www.x.org/wiki/ https://cgit.freedesktop.org/"

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI="https://anongit.freedesktop.org/git/xorg/xserver.git"
	inherit autotools git-r3
else
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux"
	SRC_URI="mirror://xorg/xserver/${P}.tar.bz2"
fi

LICENSE="MIT"
SLOT="0/${PV}"
IUSE_SERVERS="dmx kdrive wayland xephyr xnest xorg xvfb"
IUSE="${IUSE_SERVERS} debug doc +glamor ipv6 libressl minimal selinux static-libs systemd +udev unwind xcsecurity"

CDEPEND="
	>=app-eselect/eselect-opengl-1.3.0
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )
	>=x11-apps/iceauth-1.0.2
	>=x11-apps/rgb-1.0.3
	>=x11-apps/xauth-1.0.3
	x11-apps/xkbcomp
	>=x11-libs/libdrm-2.4.89
	>=x11-libs/libpciaccess-0.12.901
	>=x11-libs/libXau-1.0.4
	>=x11-libs/libXdmcp-1.0.2
	>=x11-libs/libXfont2-2.0.1
	>=x11-libs/libxkbfile-1.0.4
	>=x11-libs/libxshmfence-1.1
	>=x11-libs/pixman-0.27.2
	>=x11-libs/xtrans-1.3.5
	>=x11-misc/xbitmaps-1.0.1
	>=x11-misc/xkeyboard-config-2.4.1-r3
	dmx? (
		x11-libs/libXt
		>=x11-libs/libdmx-1.0.99.1
		>=x11-libs/libX11-1.1.5
		>=x11-libs/libXaw-1.0.4
		>=x11-libs/libXext-1.0.99.4
		>=x11-libs/libXfixes-5.0
		>=x11-libs/libXi-1.2.99.1
		>=x11-libs/libXmu-1.0.3
		x11-libs/libXrender
		>=x11-libs/libXres-1.0.3
		>=x11-libs/libXtst-1.0.99.2
	)
	glamor? (
		media-libs/libepoxy[X]
		>=media-libs/mesa-10.3.4-r1[egl,gbm]
		!x11-libs/glamor
	)
	kdrive? (
		>=x11-libs/libXext-1.0.5
		x11-libs/libXv
	)
	xephyr? (
		x11-libs/libxcb[xkb]
		x11-libs/xcb-util
		x11-libs/xcb-util-image
		x11-libs/xcb-util-keysyms
		x11-libs/xcb-util-renderutil
		x11-libs/xcb-util-wm
	)
	!minimal? (
		>=x11-libs/libX11-1.1.5
		>=x11-libs/libXext-1.0.5
		>=media-libs/mesa-10.3.4-r1
	)
	udev? ( virtual/libudev:= )
	unwind? ( sys-libs/libunwind )
	wayland? (
		>=dev-libs/wayland-1.3.0
		media-libs/libepoxy
		>=dev-libs/wayland-protocols-1.1
	)
	>=x11-apps/xinit-1.3.3-r1
	systemd? (
		sys-apps/dbus
		sys-apps/systemd
	)"

DEPEND="
	${CDEPEND}
	>=media-fonts/font-util-1.2.0
	sys-devel/flex
	>=x11-misc/util-macros-1.18
	>=x11-base/xorg-proto-2018.3
	dmx? (
		doc? (
			|| (
				www-client/links
				www-client/lynx
				www-client/w3m
			)
		)
	)"

RDEPEND="${CDEPEND}
	selinux? ( sec-policy/selinux-xserver )
	!x11-drivers/xf86-video-modesetting
"

PDEPEND="
	xorg? ( >=x11-base/xorg-drivers-$(ver_cut 1-2) )"

REQUIRED_USE="!minimal? (
		|| ( ${IUSE_SERVERS} )
	)
	xephyr? ( kdrive )"

UPSTREAMED_PATCHES=(
	"${FILESDIR}"/${P}-xfree86-Inline-xf86-Read-Write-Mmio-8-16-32-on-alpha.patch
)

PATCHES=(
	"${UPSTREAMED_PATCHES[@]}"
	"${FILESDIR}"/${PN}-1.12-unloadsubmodule.patch
	# needed for new eselect-opengl, bug #541232
	"${FILESDIR}"/${PN}-1.18-support-multiple-Files-sections.patch
)

pkg_pretend() {
	# older gcc is not supported
	[[ "${MERGE_TYPE}" != "binary" && $(gcc-major-version) -lt 4 ]] && \
		die "Sorry, but gcc earlier than 4.0 will not work for xorg-server."
}

pkg_setup() {
	if use wayland && ! use glamor; then
		ewarn "glamor is necessary for acceleration under Xwayland."
		ewarn "Performance may be unacceptable without it."
	fi
}

src_prepare() {
	default
	[[ ${PV} == 9999* ]] && eautoreconf
}

src_configure() {
	# localstatedir is used for the log location; we need to override the default
	#	from ebuild.sh
	# sysconfdir is used for the xorg.conf location; same applies
	# NOTE: fop is used for doc generating; and I have no idea if Gentoo
	#	package it somewhere
	local econfargs=(
		$(use_enable ipv6)
		$(use_enable debug)
		$(use_enable dmx)
		$(use_enable glamor)
		$(use_enable kdrive)
		$(use_enable static-libs static)
		$(use_enable unwind libunwind)
		$(use_enable wayland xwayland)
		$(use_enable !minimal record)
		$(use_enable !minimal xfree86-utils)
		$(use_enable !minimal dri)
		$(use_enable !minimal dri2)
		$(use_enable !minimal glx)
		$(use_enable xcsecurity)
		$(use_enable xephyr)
		$(use_enable xnest)
		$(use_enable xorg)
		$(use_enable xvfb)
		$(use_enable udev config-udev)
		$(use_with doc doxygen)
		$(use_with doc xmlto)
		$(use_with systemd systemd-daemon)
		$(use_enable systemd systemd-logind)
		$(use_enable systemd suid-wrapper)
		$(use_enable !systemd install-setuid)
		--enable-libdrm
		--sysconfdir="${EPREFIX%/}"/etc/X11
		--localstatedir="${EPREFIX%/}"/var
		--with-fontrootdir="${EPREFIX%/}"/usr/share/fonts
		--with-xkb-output="${EPREFIX%/}"/var/lib/xkb
		--disable-config-hal
		--disable-linux-acpi
		--without-dtrace
		--without-fop
		--with-os-vendor=Gentoo
		--with-sha1=libcrypto
	)

	econf "${econfargs[@]}"
}

src_install() {
	default

	server_based_install

	if ! use minimal && use xorg; then
		# Install xorg.conf.example into docs
		dodoc hw/xfree86/xorg.conf.example
	fi

	newinitd "${FILESDIR}"/xdm-setup.initd-1 xdm-setup
	newinitd "${FILESDIR}"/xdm.initd-11 xdm
	newconfd "${FILESDIR}"/xdm.confd-4 xdm

	# install the @x11-module-rebuild set for Portage
	insinto /usr/share/portage/config/sets
	newins "${FILESDIR}"/xorg-sets.conf xorg.conf
	find "${D}" -name '*.la' -delete
}

pkg_postinst() {
	# sets up libGL and DRI2 symlinks if needed (ie, on a fresh install)
	eselect opengl set xorg-x11 --use-old
}

pkg_postrm() {
	# Get rid of module dir to ensure opengl-update works properly
	if [[ -z ${REPLACED_BY_VERSION} && -e ${EROOT%/}/usr/$(get_libdir)/xorg/modules ]]; then
		rm -rf "${EROOT%/}"/usr/$(get_libdir)/xorg/modules
	fi
}

server_based_install() {
	if ! use xorg; then
		rm "${ED%/}"/usr/share/man/man1/Xserver.1x \
			"${ED%/}"/usr/$(get_libdir)/xserver/SecurityPolicy \
			"${ED%/}"/usr/$(get_libdir)/pkgconfig/xorg-server.pc \
			"${ED%/}"/usr/share/man/man1/Xserver.1x
	fi
}
