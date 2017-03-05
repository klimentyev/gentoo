# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.2.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="An HTTP client engine, intended as a base layer for more user-friendly packages"
HOMEPAGE="https://github.com/snoyberg/http-client"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/base64-bytestring-1.0:=[profile?] <dev-haskell/base64-bytestring-1.1:=[profile?]
	>=dev-haskell/blaze-builder-0.3:=[profile?]
	>=dev-haskell/case-insensitive-1.0:=[profile?]
	dev-haskell/cookie:=[profile?]
	dev-haskell/data-default-class:=[profile?]
	>=dev-haskell/exceptions-0.4:=[profile?]
	>=dev-haskell/http-types-0.8:=[profile?]
	dev-haskell/mime-types:=[profile?]
	>=dev-haskell/network-2.3:=[profile?]
	dev-haskell/publicsuffixlist:=[profile?]
	dev-haskell/random:=[profile?]
	>=dev-haskell/streaming-commons-0.1.0.2:=[profile?] <dev-haskell/streaming-commons-0.2:=[profile?]
	>=dev-haskell/text-0.11:=[profile?]
	dev-haskell/transformers:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( dev-haskell/async
		dev-haskell/hspec
		dev-haskell/monad-control
		>=dev-haskell/streaming-commons-0.1.1
		dev-haskell/zlib )
"

# Prior to version 0.4.6.1, the test suite required internet access.
RESTRICT="test"
