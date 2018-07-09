# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.5

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="A modern, easy to use, well-documented, extensible prettyprinter"
HOMEPAGE="https://github.com/quchen/prettyprinter"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-haskell/semigroups-0.1:=[profile?]
	>=dev-haskell/text-1.2:=[profile?]
	dev-haskell/void:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
	test? ( >=dev-haskell/doctest-0.9
		>=dev-haskell/pgp-wordlist-0.1
		>=dev-haskell/semigroups-0.6
		>=dev-haskell/tasty-0.10
		>=dev-haskell/tasty-hunit-0.9
		>=dev-haskell/tasty-quickcheck-0.8 )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag doc buildreadme)
}
