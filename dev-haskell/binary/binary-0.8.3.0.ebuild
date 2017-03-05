# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Binary serialisation for Haskell values using lazy ByteStrings"
HOMEPAGE="https://github.com/kolmodin/binary"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
# keep in sync with ghc-8.0.1
KEYWORDS="~alpha ~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RESTRICT=test # binary[test]->test-framework->text->xml->binary

RDEPEND=">=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
	test? ( dev-haskell/hunit
		>=dev-haskell/quickcheck-2.8
		>=dev-haskell/random-1.0.1.0
		dev-haskell/test-framework
		>=dev-haskell/test-framework-quickcheck2-0.3 )
"

CABAL_CORE_LIB_GHC_PV="PM:8.0.1 PM:8.0.2_rc1 PM:8.0.2_rc2 PM:8.0.2 PM:9999"
