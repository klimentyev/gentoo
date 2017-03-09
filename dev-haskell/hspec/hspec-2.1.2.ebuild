# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.4.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="A Testing Framework for Haskell"
HOMEPAGE="http://hspec.github.io/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="~dev-haskell/hspec-core-2.1.2:=[profile?]
	~dev-haskell/hspec-discover-2.1.2:=[profile?]
	>=dev-haskell/hspec-expectations-0.6.1:=[profile?] <dev-haskell/hspec-expectations-0.6.2:=[profile?]
	>=dev-haskell/hunit-1.2.5:=[profile?]
	>=dev-haskell/quickcheck-2.5.1:2=[profile?]
	>=dev-haskell/transformers-0.2.2.0:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( dev-haskell/hspec-core
		>=dev-haskell/hspec-meta-1.12
		dev-haskell/stringbuilder )
"
