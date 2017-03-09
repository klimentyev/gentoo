# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.3.2.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Stream socket data using conduits"
HOMEPAGE="https://github.com/snoyberg/conduit"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="=dev-haskell/conduit-1.0*:=[profile?]
		>=dev-haskell/lifted-base-0.1:=[profile?]
		=dev-haskell/monad-control-0.3*:=[profile?]
		>=dev-haskell/transformers-0.2.2:=[profile?]
		<dev-haskell/transformers-0.4:=[profile?]
		>=dev-lang/ghc-6.10.4:=
		>=dev-haskell/network-2.3:=[profile?]
		"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8"
