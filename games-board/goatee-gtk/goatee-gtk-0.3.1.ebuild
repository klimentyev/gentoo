# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.9999

CABAL_FEATURES="bin lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="A monadic take on a 2,500-year-old board game - GTK+ UI"
HOMEPAGE="http://khumba.net/projects/goatee"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-games/goatee-0.3:=[profile?] <dev-games/goatee-0.4:=[profile?]
	>=dev-haskell/cairo-0.13:=[profile?] <dev-haskell/cairo-0.14:=[profile?]
	>=dev-haskell/glib-0.13:=[profile?] <dev-haskell/glib-0.14:=[profile?]
	>=dev-haskell/gtk-0.13:=[profile?]
	>=dev-haskell/mtl-2.1:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-haskell/parsec-3.1:=[profile?] <dev-haskell/parsec-3.2:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	test? ( >=dev-haskell/hunit-1.2 )
"

src_prepare() {
	default

	cabal_chdeps \
		'HUnit >= 1.2 && < 1.3' 'HUnit >= 1.2' \
		'gtk >= 0.13 && < 0.14' 'gtk >= 0.13'
}
