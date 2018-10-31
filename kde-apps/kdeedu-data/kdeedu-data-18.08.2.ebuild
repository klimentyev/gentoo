# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_AUTODEPS="false"
KDE_DEBUG="false"
inherit kde5

DESCRIPTION="Shared icons, artwork and data files for educational applications"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	$(add_frameworks_dep extra-cmake-modules)
	$(add_qt_dep qtcore)
"
RDEPEND="
	!kde-apps/libkdeedu:4
	!kde-apps/kde-l10n
"
