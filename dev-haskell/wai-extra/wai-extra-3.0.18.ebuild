# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Provides some basic WAI handlers and middleware"
HOMEPAGE="https://github.com/yesodweb/wai"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/ansi-terminal:=[profile?]
	dev-haskell/base64-bytestring:=[profile?]
	>=dev-haskell/blaze-builder-0.2.1.4:=[profile?] <dev-haskell/blaze-builder-0.5:=[profile?]
	>=dev-haskell/case-insensitive-0.2:=[profile?]
	dev-haskell/cookie:=[profile?]
	dev-haskell/data-default-class:=[profile?]
	>=dev-haskell/fast-logger-2.4.5:=[profile?] <dev-haskell/fast-logger-2.5:=[profile?]
	>=dev-haskell/http-types-0.7:=[profile?]
	dev-haskell/iproute:=[profile?]
	>=dev-haskell/lifted-base-0.1.2:=[profile?]
	>=dev-haskell/network-2.6.1.0:=[profile?]
	>=dev-haskell/old-locale-1.0.0.2:=[profile?] <dev-haskell/old-locale-1.1:=[profile?]
	>=dev-haskell/resourcet-0.4.6:=[profile?] <dev-haskell/resourcet-1.2:=[profile?]
	dev-haskell/streaming-commons:=[profile?]
	>=dev-haskell/stringsearch-0.3:=[profile?] <dev-haskell/stringsearch-0.4:=[profile?]
	>=dev-haskell/text-0.7:=[profile?]
	dev-haskell/unix-compat:=[profile?]
	dev-haskell/vault:=[profile?]
	>=dev-haskell/void-0.5:=[profile?]
	>=dev-haskell/wai-3.0.3.0:=[profile?] <dev-haskell/wai-3.3:=[profile?]
	>=dev-haskell/wai-logger-2.2.6:=[profile?] <dev-haskell/wai-logger-2.4:=[profile?]
	dev-haskell/word8:=[profile?]
	dev-haskell/zlib:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
	test? ( >=dev-haskell/hspec-1.3
		dev-haskell/hunit )
"
