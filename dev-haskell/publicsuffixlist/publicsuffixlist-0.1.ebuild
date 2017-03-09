# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Is a given string a domain suffix?"
HOMEPAGE="https://github.com/litherum/publicsuffixlist"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 x86"
IUSE="create runtimelist"

RDEPEND="dev-haskell/cereal:=[profile?]
	dev-haskell/data-default:=[profile?]
	>=dev-haskell/text-0.11:=[profile?]
	dev-haskell/utf8-string:=[profile?]
	>=dev-lang/ghc-7.4.1:=
	create? ( >=dev-haskell/conduit-1.0.0:=[profile?] <dev-haskell/conduit-2.0.0:=[profile?]
			>=dev-haskell/idna-0.1.2:=[profile?] <dev-haskell/idna-1.0:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	test? ( dev-haskell/hunit
		!create? ( >=dev-haskell/idna-0.1.1 <dev-haskell/idna-1.0 ) )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag create create) \
		$(cabal_flag runtimelist runtimelist)
}
