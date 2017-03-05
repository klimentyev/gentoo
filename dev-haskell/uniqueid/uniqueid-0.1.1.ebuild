# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.3.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit eutils haskell-cabal

DESCRIPTION="Splittable Unique Identifier Supply"
HOMEPAGE="https://github.com/sebfisch/uniqueid/wikis"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-7.8.1:="
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ghc-7.8.patch
}
