# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{4,5,6,7}} )

inherit cmake-utils python-r1

DESCRIPTION="Raw bytes manipulation, transformations (decoding and more) and interception"
HOMEPAGE="https://github.com/metrodango/pip3line"

KEYWORDS=""
SRC_URI=""

if [[ ${PV} == 9999* ]] ; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/metrodango/pip3line.git"
    EGIT_BRANCH="master"
else
    SRC_URI="https://github.com/metrodango/pip3line/archive/v${PV}.tar.gz  -> ${P}.tar.gz"
    KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="distorm openssl qscintilla"

RDEPEND="
	${PYTHON_DEPS}
    dev-qt/qtconcurrent:5
    dev-qt/qtcore:5
    dev-qt/qtgui:5
    dev-qt/qtnetwork:5
    dev-qt/qtsvg:5
    dev-qt/qtwidgets:5
    dev-qt/qtxmlpatterns:5
    distorm? ( dev-libs/distorm64 )
    openssl? ( dev-libs/openssl:0= )
    qscintilla? ( x11-libs/qscintilla )"

DEPEND="${RDEPEND}"

src_configure() {

    if [[ "${PYTHON_TARGETS}" == *python3* ]]; then
        python3_usage=yes
    else
        python3_usage=no
    fi

    local mycmakeargs=(
        -DBASIC=yes
        -DWITH_OPENSSL=$(usex openssl)
        -DWITH_PYTHON27=$(usex python_targets_python2_7)
        -DWITH_PYTHON3=${python3_usage}
        -DWITH_SCINTILLA=$(usex qscintilla)
        -DWITH_DISTORM=$(usex distorm)
    )

    cd ext || die
    ./gen_distorm.sh || die

    cmake-utils_src_configure
}

pkg_postinst() {
    if use distorm ; then
        echo
        ewarn "The Distorm plugin was compiled."
        ewarn "Beware the current distorm64 installation does not"
        ewarn "copy the necessary files at the right place."
        ewarn "The native library is in :"
        ewarn "/usr/lib64/python[version]/site-packages/distorm3/libdistorm3.so"
        ewarn "If you want the plugin to load properly create a link of this"
        ewarn "lib in /usr/lib64 or /usr/local/lib Whichever you prefer"
        echo
    fi
}
