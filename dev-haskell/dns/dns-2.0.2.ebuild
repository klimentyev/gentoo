# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="DNS library in Haskell"
HOMEPAGE="http://hackage.haskell.org/package/dns"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT=test # ambiguous modules: ip-route / network-data

RDEPEND="dev-haskell/attoparsec:=[profile?]
	dev-haskell/binary:=[profile?]
	dev-haskell/blaze-builder:=[profile?]
	>=dev-haskell/conduit-1.1:=[profile?]
	>=dev-haskell/conduit-extra-1.1:=[profile?]
	>=dev-haskell/iproute-1.3.2:=[profile?]
	dev-haskell/mtl:=[profile?]
	>=dev-haskell/network-2.3:=[profile?]
	dev-haskell/random:=[profile?]
	dev-haskell/resourcet:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( dev-haskell/doctest
		dev-haskell/hspec
		dev-haskell/word8 )
"
