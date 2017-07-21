# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit kde5-meta-pkg

DESCRIPTION="kdegraphics - merge this to pull in all kdegraphics-derived packages"
HOMEPAGE="https://www.kde.org/applications/graphics/"
KEYWORDS="amd64 x86"
IUSE="nls scanner"

[[ ${KDE_BUILD_TYPE} = live ]] && L10N_MINIMAL=${KDE_APPS_MINIMAL}

RDEPEND="
	$(add_kdeapps_dep gwenview)
	$(add_kdeapps_dep kamera)
	$(add_kdeapps_dep kcolorchooser)
	$(add_kdeapps_dep kdegraphics-mobipocket)
	$(add_kdeapps_dep kolourpaint)
	$(add_kdeapps_dep kruler)
	$(add_kdeapps_dep libkdcraw)
	$(add_kdeapps_dep libkexiv2)
	$(add_kdeapps_dep libkipi)
	$(add_kdeapps_dep okular)
	$(add_kdeapps_dep spectacle)
	$(add_kdeapps_dep svgpart)
	$(add_kdeapps_dep thumbnailers)
	nls? (
		$(add_kdeapps_dep kde-l10n '' ${L10N_MINIMAL})
		$(add_kdeapps_dep kde4-l10n '' ${L10N_MINIMAL})
	)
	scanner? (
		$(add_kdeapps_dep ksaneplugin)
		$(add_kdeapps_dep libksane)
	)
"
