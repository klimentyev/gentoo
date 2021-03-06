# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_HANDBOOK="true"
KDE_SELINUX_MODULE="games"
inherit kde5

DESCRIPTION="Skat game by KDE"
HOMEPAGE="
	https://www.kde.org/applications/games/lskat/
	https://games.kde.org/game.php?game=lskat
"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep libkdegames)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtsvg)
	$(add_qt_dep qtwidgets)
"
RDEPEND="${DEPEND}
	!<kde-apps/kde4-l10n-17.07.80
"

src_prepare() {
	kde5_src_prepare
	punt_bogus_dep Phonon 4Qt5
}
