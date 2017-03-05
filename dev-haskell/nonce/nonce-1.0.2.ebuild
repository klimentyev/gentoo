# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Generate cryptographic nonces"
HOMEPAGE="https://github.com/prowdsponsor/nonce"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/base64-bytestring-1.0:=[profile?] <dev-haskell/base64-bytestring-1.1:=[profile?]
	>=dev-haskell/cprng-aes-0.5:=[profile?] <dev-haskell/cprng-aes-0.7:=[profile?]
	>=dev-haskell/crypto-random-0.0:=[profile?] <dev-haskell/crypto-random-0.1:=[profile?]
	>=dev-haskell/text-0.9:=[profile?]
	>=dev-haskell/transformers-0.2:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
"

src_prepare() {
	cabal_chdeps \
		'base              >= 4.5   && < 4.9' 'base              >= 4.5'
}
