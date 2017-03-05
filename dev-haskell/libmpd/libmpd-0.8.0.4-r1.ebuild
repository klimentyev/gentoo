# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="An MPD client library"
HOMEPAGE="https://github.com/joachifm/libmpd-haskell#readme"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="test" # Could not find module Test.Hspec.Monadic

RDEPEND=">=dev-haskell/attoparsec-0.10.1:=[profile?] <dev-haskell/attoparsec-0.13:=[profile?]
	>=dev-haskell/data-default-0.4.0:=[profile?] <dev-haskell/data-default-0.6:=[profile?]
	>=dev-haskell/mtl-2.0:=[profile?] <dev-haskell/mtl-3:=[profile?]
	>=dev-haskell/network-2.1:=[profile?] <dev-haskell/network-2.6:=[profile?]
	>=dev-haskell/text-0.11:=[profile?]
	>=dev-haskell/utf8-string-0.3.1:=[profile?] <dev-haskell/utf8-string-0.4:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( dev-haskell/data-default
		dev-haskell/hspec
		dev-haskell/hunit
		dev-haskell/mtl
		dev-haskell/network
		>=dev-haskell/quickcheck-2.1
		dev-haskell/text
		dev-haskell/utf8-string )
"

src_prepare() {
	cabal_chdeps \
		'attoparsec >= 0.10.1 && < 0.12' 'attoparsec >= 0.10.1 && < 0.13'
}
