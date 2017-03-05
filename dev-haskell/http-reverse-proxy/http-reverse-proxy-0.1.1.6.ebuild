# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.3.2.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Reverse proxy HTTP requests, either over raw sockets or with WAI"
HOMEPAGE="https://github.com/fpco/http-reverse-proxy"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/blaze-builder-0.3:=[profile?]
		>=dev-haskell/case-insensitive-0.4:=[profile?]
		>=dev-haskell/classy-prelude-0.3:=[profile?]
		>=dev-haskell/conduit-0.5:=[profile?]
		dev-haskell/data-default:=[profile?]
		>=dev-haskell/http-conduit-1.6:=[profile?]
		>=dev-haskell/http-types-0.6:=[profile?]
		>=dev-haskell/lifted-base-0.1:=[profile?]
		>=dev-haskell/monad-control-0.3:=[profile?]
		dev-haskell/network:=[profile?]
		>=dev-haskell/network-conduit-0.6:=[profile?]
		>=dev-haskell/text-0.11:=[profile?]
		>=dev-haskell/wai-1.3:=[profile?]
		>=dev-haskell/warp-1.3.4:=[profile?]
		>=dev-haskell/word8-0.0:=[profile?]
		>=dev-lang/ghc-6.10.4:="
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8
		test? ( >=dev-haskell/hspec-1.3
			dev-haskell/transformers
		)"
