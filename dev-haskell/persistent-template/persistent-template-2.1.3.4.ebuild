# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Type-safe, non-relational, multi-backend persistence"
HOMEPAGE="https://www.yesodweb.com/book/persistent"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/aeson-0.7:=[profile?] <dev-haskell/aeson-0.10:=[profile?]
	>=dev-haskell/monad-control-0.2:=[profile?] <dev-haskell/monad-control-1.1:=[profile?]
	dev-haskell/monad-logger:=[profile?]
	dev-haskell/path-pieces:=[profile?]
	>=dev-haskell/persistent-2.1.3:=[profile?] <dev-haskell/persistent-3:=[profile?]
	dev-haskell/tagged:=[profile?]
	>=dev-haskell/text-0.5:=[profile?]
	>=dev-haskell/transformers-0.2:=[profile?] <dev-haskell/transformers-0.5:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	>=dev-lang/ghc-7.6.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.16.0
	test? ( >=dev-haskell/hspec-1.3
		dev-haskell/quickcheck )
"
