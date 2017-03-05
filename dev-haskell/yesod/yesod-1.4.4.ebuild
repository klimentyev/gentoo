# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Creation of type-safe, RESTful web applications"
HOMEPAGE="http://www.yesodweb.com/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/aeson:=[profile?]
	>=dev-haskell/blaze-html-0.5:=[profile?]
	>=dev-haskell/blaze-markup-0.5.1:=[profile?]
	dev-haskell/conduit:=[profile?]
	>=dev-haskell/conduit-extra-1.1.14:=[profile?]
	dev-haskell/data-default-class:=[profile?]
	dev-haskell/fast-logger:=[profile?]
	>=dev-haskell/monad-control-0.3:=[profile?] <dev-haskell/monad-control-1.1:=[profile?]
	dev-haskell/monad-logger:=[profile?]
	dev-haskell/resourcet:=[profile?]
	dev-haskell/semigroups:=[profile?]
	dev-haskell/shakespeare:=[profile?]
	dev-haskell/streaming-commons:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	>=dev-haskell/wai-1.3:=[profile?]
	>=dev-haskell/wai-extra-1.3:=[profile?]
	dev-haskell/wai-logger:=[profile?]
	>=dev-haskell/warp-1.3:=[profile?]
	>=dev-haskell/yaml-0.8.17:=[profile?]
	>=dev-haskell/yesod-core-1.4:=[profile?] <dev-haskell/yesod-core-1.5:=[profile?]
	>=dev-haskell/yesod-form-1.4:=[profile?] <dev-haskell/yesod-form-1.5:=[profile?]
	>=dev-haskell/yesod-persistent-1.4:=[profile?] <dev-haskell/yesod-persistent-1.5:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
"
