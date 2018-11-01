# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit udev user

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI="git://git.code.sf.net/p/${PN}/code"
	inherit autotools git-r3
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~x86 ~amd64-fbsd ~x86-fbsd"
fi

DESCRIPTION="Implementation of Microsoft's Media Transfer Protocol (MTP)"
HOMEPAGE="http://libmtp.sourceforge.net/"

LICENSE="LGPL-2.1" # LGPL-2+ and LGPL-2.1+ ?
SLOT="0/9" # Based on SONAME of libmtp shared library
IUSE="+crypt doc examples static-libs"

RDEPEND="virtual/libusb:1
	crypt? ( >=dev-libs/libgcrypt-1.5.4:0= )"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

DOCS=( AUTHORS README TODO )

pkg_setup() {
	enewgroup plugdev
}

src_prepare() {
	default

	# ChangeLog says "RETIRING THIS FILE ..pause..  GIT" (Last entry from start of 2011)
	rm ChangeLog || die

	if [[ ${PV} == 9999* ]]; then
		local crpthf=config.rpath
		local crpthd=/usr/share/gettext/${crpthf}
		if has_version '>sys-devel/gettext-0.18.3' && [[ -e ${crpthd} ]]; then
			cp "${crpthd}" . || die
		else
			touch ${crpthf} || die # This is from upstream autogen.sh
		fi
		eautoreconf
	fi
}

src_configure() {
	local myeconfargs=(
		$(use_enable crypt mtpz)
		$(use_enable doc doxygen)
		$(use_enable static-libs static)
		--with-udev="$(get_udevdir)"
		--with-udev-group=plugdev
		--with-udev-mode=0660
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	default
	find "${ED}" -name "*.la" -delete || die

	if use examples; then
		docinto examples
		dodoc examples/*.{c,h,sh}
	fi
}
