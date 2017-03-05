# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Bindings for GNU libgsasl"
HOMEPAGE="https://john-millikin.com/software/haskell-gsasl/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/transformers-0.2:=[profile?]
	>=dev-lang/ghc-7.4.1:=
	virtual/gsasl
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
	virtual/pkgconfig
"
