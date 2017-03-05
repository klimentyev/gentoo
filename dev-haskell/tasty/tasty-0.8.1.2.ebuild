# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.2.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Modern and extensible testing framework"
HOMEPAGE="http://documentup.com/feuerbach/tasty"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-haskell/ansi-terminal-0.6.1:=[profile?]
	>=dev-haskell/async-2.0:=[profile?]
	dev-haskell/mtl:=[profile?]
	>=dev-haskell/optparse-applicative-0.6:=[profile?]
	>=dev-haskell/regex-tdfa-1.2:=[profile?]
	>=dev-haskell/stm-2.3:=[profile?]
	>=dev-haskell/tagged-0.5:=[profile?]
	>=dev-haskell/unbounded-delays-0.1:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
"
