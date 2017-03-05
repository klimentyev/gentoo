# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.9999
#hackport: flags: -usenativewindowslibraries,-useglxgetprocaddress

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

MY_PN="OpenGLRaw"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A raw binding for the OpenGL graphics system"
HOMEPAGE="http://www.haskell.org/haskellwiki/Opengl"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 ~sparc x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-7.4.1:=
	virtual/opengl
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
"

S="${WORKDIR}/${MY_P}"

src_configure() {
	haskell-cabal_src_configure \
		--flag=-useglxgetprocaddress \
		--flag=-usenativewindowslibraries
}
