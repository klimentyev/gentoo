# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="https://github.com/swaywm/wlroots.git"
	inherit git-r3
else
	SRC_URI="https://github.com/swaywm/wlroots/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

inherit fcaps meson

DESCRIPTION="Pluggable, composable, unopinionated modules for building a Wayland compositor"
HOMEPAGE="https://github.com/swaywm/wlroots"

LICENSE="MIT"
SLOT="0"
IUSE="elogind icccm rootston systemd x11-backend X"
REQUIRED_USE="?? ( elogind systemd )"

RDEPEND=">=dev-libs/libinput-1.7.0:0=
	>=dev-libs/wayland-1.16.0
	>=dev-libs/wayland-protocols-1.15
	media-libs/mesa[egl,gles2,gbm]
	virtual/libudev
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-libs/pixman
	elogind? ( >=sys-auth/elogind-237 )
	icccm? ( x11-libs/xcb-util-wm )
	systemd? ( >=sys-apps/systemd-237 )
	x11-backend? ( x11-libs/libxcb:0=[xkb] )
	X? (
		x11-base/xorg-server[wayland]
		x11-libs/libxcb:0=
	)"
DEPEND="${RDEPEND}"
BDEPEND=">=dev-util/meson-0.48
	virtual/pkgconfig"

FILECAPS=( cap_sys_admin usr/bin/rootston )

src_configure() {
	# xcb-util-errors is not on Gentoo Repository (and upstream seems inactive?)
	local emesonargs=(
		"-Dxcb-errors=disabled"
		-Dlibcap=$(usex filecaps enabled disabled)
		-Dxcb-icccm=$(usex icccm enabled disabled)
		-Dxcb-xkb=$(usex x11-backend enabled disabled)
		-Dxwayland=$(usex X enabled disabled)
		-Dx11-backend=$(usex x11-backend enabled disabled)
		-Drootston=$(usex rootston true false)
		"-Dexamples=false"
		"-Dwerror=false"
	)
	if use systemd ; then
		emesonargs+=("-Dlogind=enabled" "-Dlogind-provider=systemd")
	elif use elogind ; then
		emesonargs+=("-Dlogind=enabled" "-Dlogind-provider=elogind")
	else
		emesonargs+=("-Dlogind=disabled")
	fi

	meson_src_configure
}

src_install() {
	if use rootston ; then
		dobin "${BUILD_DIR}"/rootston/rootston
		newdoc rootston/rootston.ini.example rootston.ini
	fi

	meson_src_install
}

pkg_postinst() {
	elog "You must be in the input group to allow your compositor"
	elog "to access input devices via libinput."
	if use rootston ; then
		elog ""
		elog "You should copy (and decompress) the example configuration file"
		elog "from ${EROOT:-${ROOT}}/usr/share/doc/${PF}/rootston.ini"
		elog "to the working directory from where you launch rootston"
		elog "(or pass the '-C path-to-config' option to rootston)."
		if ! use systemd && ! use elogind ; then
			elog ""
			elog "If you use ConsoleKit2, remember to launch rootston using:"
			elog "exec ck-launch-session rootston"

			fcaps_pkg_postinst
		fi
	fi
}
