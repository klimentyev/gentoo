# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd unpacker user

DESCRIPTION="A free media library that is intended for use with a plex client"
HOMEPAGE="https://www.plex.tv/"

COMMIT="ecd600442"

_APPNAME="plexmediaserver"
_USERNAME="plex"
_SHORTNAME="${_USERNAME}"
_FULL_VERSION="${PV}-${COMMIT}"

SRC_URI="
	amd64? ( https://downloads.plex.tv/${PN}/${_FULL_VERSION}/${_APPNAME}_${_FULL_VERSION}_amd64.deb )
	x86? ( https://downloads.plex.tv/${PN}/${_FULL_VERSION}/${_APPNAME}_${_FULL_VERSION}_i386.deb )"

LICENSE="Plex"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="mirror bindist strip"
IUSE="avahi"

DEPEND="sys-apps/fix-gnustack"
RDEPEND="avahi? ( net-dns/avahi )"

QA_DESKTOP_FILE="usr/share/applications/plexmediamanager.desktop"
QA_PREBUILT="*"
QA_MULTILIB_PATHS=( "usr/lib/${_APPNAME}/.*" )

PATCHES=( "${FILESDIR}"/plexmediamanager.desktop.patch )

S="${WORKDIR}"

pkg_setup() {
	enewgroup ${_USERNAME}
	enewuser ${_USERNAME} -1 /bin/bash /var/lib/${_APPNAME} "${_USERNAME},video"
}

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	# Move the config to the correct place
	local config_vanilla="/etc/default/${_APPNAME}"
	local config_path="/etc/${_SHORTNAME}"
	dodir "${config_path}"
	insinto "${config_path}"
	doins "${config_vanilla#/}"
	sed -e "s#${config_vanilla}#${config_path}/$(basename "${config_vanilla}")#g" \
		-i "${S}"/usr/sbin/start_pms || die

	# Remove Debian specific files
	rm -r "usr/share/doc" || die

	# Copy main files over to image and preserve permissions so it is portable
	cp -rp usr/ "${ED}" || die

	# Make sure the logging directory is created
	local logging_dir="/var/log/pms"
	dodir "${logging_dir}"
	fowners "${_USERNAME}":"${_USERNAME}" "${logging_dir}"

	# Create default library folder with correct permissions
	local default_library_dir="/var/lib/${_APPNAME}"
	dodir "${default_library_dir}"
	fowners "${_USERNAME}":"${_USERNAME}" "${default_library_dir}"

	# Install the OpenRC init/conf files depending on avahi.
	if use avahi; then
		doinitd "${FILESDIR}/init.d/${PN}"
	else
		cp "${FILESDIR}/init.d/${PN}" "${S}/${PN}" || die
		sed -e '/depend/ s/^#*/#/' \
		-e '/need/ s/^#*/#/' \
		-e '1,/^}/s/^}/#}/' -i "${S}/${PN}" || die
		doinitd "${S}/${PN}"
	fi

	fix-gnustack -f ${ED}/usr/lib/${_APPNAME}/libgnsdk_dsp.so* || die

	doconfd "${FILESDIR}/conf.d/${PN}"

	# Install systemd service file
	systemd_newunit "${FILESDIR}"/systemd/${PN}.service ${PN}.service

	newenvd - 66plex <<< LDPATH="${EPREFIX}/usr/$(get_libdir)/${_APPNAME}"
}

pkg_postinst() {
	einfo ""
	elog "Plex Media Server is now installed. Please check the configuration file"
	elog "It can be found in /etc/${_SHORTNAME}/${_APPNAME} to verify the default settings."
	elog "To start the Plex Server, run 'rc-config start plex-media-server'"
	elog "You will then be able to access your library at http://<ip>:32400/web/index.html"
}
