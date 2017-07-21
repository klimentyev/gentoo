# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Compression and decompression in the gzip and zlib formats"
HOMEPAGE="http://hackage.haskell.org/package/zlib"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x86-macos"
IUSE="non-blocking-ffi"

RDEPEND=">=dev-lang/ghc-7.4.1:=
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( >=dev-haskell/quickcheck-2 <dev-haskell/quickcheck-3
		>=dev-haskell/tasty-0.8 <dev-haskell/tasty-0.12
		>=dev-haskell/tasty-hunit-0.8 <dev-haskell/tasty-hunit-0.10
		>=dev-haskell/tasty-quickcheck-0.8 <dev-haskell/tasty-quickcheck-0.9 )
"

PATCHES=("${FILESDIR}"/${P}-fix-w8-tests.patch)

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag non-blocking-ffi non-blocking-ffi)
}
