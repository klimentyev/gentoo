# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.5.9999
#hackport: flags: +library,+executable,-hpc,-warn-as-error,+pkgconfig,-rts,-static,-optimize,hashed-storage-diff:diff

CABAL_FEATURES="bin lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="a distributed, interactive, smart revision control system"
HOMEPAGE="http://darcs.net/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+curl diff +http +network-uri +terminfo +threaded"

RESTRICT=test # missing file 'tests/bin/renameHelper.hs'

RDEPEND=">=dev-haskell/attoparsec-0.11:=[profile?] <dev-haskell/attoparsec-0.14:=[profile?]
	>=dev-haskell/base16-bytestring-0.1:=[profile?] <dev-haskell/base16-bytestring-0.2:=[profile?]
	>=dev-haskell/binary-0.5:=[profile?] <dev-haskell/binary-0.8:=[profile?]
	>=dev-haskell/cryptohash-0.4:=[profile?] <dev-haskell/cryptohash-0.12:=[profile?]
	>=dev-haskell/data-ordlist-0.4:=[profile?] <dev-haskell/data-ordlist-0.5:=[profile?]
	>=dev-haskell/dataenc-0.11:=[profile?] <dev-haskell/dataenc-0.15:=[profile?]
	>=dev-haskell/hashable-1.0:=[profile?] <dev-haskell/hashable-1.3:=[profile?]
	>=dev-haskell/haskeline-0.6.3:=[profile?] <dev-haskell/haskeline-0.8:=[profile?]
	>=dev-haskell/html-1.0:=[profile?] <dev-haskell/html-1.1:=[profile?]
	>=dev-haskell/mmap-0.5:=[profile?] <dev-haskell/mmap-0.6:=[profile?]
	>=dev-haskell/mtl-2.1:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-haskell/old-locale-1.0:=[profile?] <dev-haskell/old-locale-1.1:=[profile?]
	>=dev-haskell/old-time-1.1:=[profile?] <dev-haskell/old-time-1.2:=[profile?]
	>=dev-haskell/parsec-3.1:=[profile?] <dev-haskell/parsec-3.2:=[profile?]
	>=dev-haskell/random-1.0:=[profile?] <dev-haskell/random-1.2:=[profile?]
	>=dev-haskell/regex-applicative-0.2:=[profile?] <dev-haskell/regex-applicative-0.4:=[profile?]
	>=dev-haskell/regex-compat-tdfa-0.95.1:=[profile?] <dev-haskell/regex-compat-tdfa-0.96:=[profile?]
	>=dev-haskell/tar-0.4:=[profile?] <dev-haskell/tar-0.5:=[profile?]
	>=dev-haskell/text-0.11.2.0:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-haskell/transformers-compat-0.4:=[profile?] <dev-haskell/transformers-compat-0.5:=[profile?]
	>=dev-haskell/unix-compat-0.1.2:=[profile?] <dev-haskell/unix-compat-0.5:=[profile?]
	>=dev-haskell/utf8-string-0.3.6:=[profile?] <dev-haskell/utf8-string-1.1:=[profile?]
	>=dev-haskell/vector-0.7:=[profile?] <dev-haskell/vector-0.11:=[profile?]
	>=dev-haskell/zip-archive-0.2.3:=[profile?] <dev-haskell/zip-archive-0.3:=[profile?]
	>=dev-haskell/zlib-0.5.3.0:=[profile?] <dev-haskell/zlib-0.7.0.0:=[profile?]
	>=dev-lang/ghc-7.4.1:=
	virtual/libiconv
	>=dev-haskell/transformers-0.3:=[profile?] <dev-haskell/transformers-0.5:=[profile?]
	curl? ( net-misc/curl )
	diff? ( dev-haskell/lcs:=[profile?] )
	http? ( >=dev-haskell/http-4000.2.3:=[profile?] <dev-haskell/http-4000.3:=[profile?]
		network-uri? ( >=dev-haskell/network-2.6:=[profile?] <dev-haskell/network-2.7:=[profile?]
				>=dev-haskell/network-uri-2.6:=[profile?] <dev-haskell/network-uri-2.7:=[profile?] )
		!network-uri? ( >=dev-haskell/network-2.3:=[profile?] <dev-haskell/network-2.6:=[profile?] ) )
	terminfo? ( >=dev-haskell/terminfo-0.3:=[profile?] <dev-haskell/terminfo-0.5:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	dev-lang/ghc
	test? ( >=dev-haskell/cmdargs-0.10 <dev-haskell/cmdargs-0.11
		>=dev-haskell/findbin-0.0 <dev-haskell/findbin-0.1
		>=dev-haskell/hunit-1.0 <dev-haskell/hunit-1.3
		>=dev-haskell/quickcheck-2.3 <dev-haskell/quickcheck-2.9
		>=dev-haskell/shelly-1.6.2 <dev-haskell/shelly-1.7
		>=dev-haskell/split-0.1.4.1 <dev-haskell/split-0.3
		>=dev-haskell/test-framework-0.4.0 <dev-haskell/test-framework-0.9
		>=dev-haskell/test-framework-hunit-0.2.2 <dev-haskell/test-framework-hunit-0.4
		>=dev-haskell/test-framework-quickcheck2-0.3 <dev-haskell/test-framework-quickcheck2-0.4 )
	curl? ( virtual/pkgconfig )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag curl curl) \
		--flag=executable \
		$(cabal_flag diff hashed-storage-diff) \
		--flag=-hpc \
		$(cabal_flag http http) \
		--flag=library \
		$(cabal_flag network-uri network-uri) \
		--flag=-optimize \
		--flag=pkgconfig \
		--flag=-rts \
		--flag=-static \
		$(cabal_flag terminfo terminfo) \
		$(cabal_flag threaded threaded) \
		--flag=-warn-as-error
}

src_install() {
	haskell-cabal_src_install

	# fixup perms in such an an awkward way
	mv "${ED}/usr/share/man/man1/darcs.1" "${S}/darcs.1" || die "darcs.1 not found"
	doman "${S}/darcs.1" || die "failed to register darcs.1 as a manpage"
}
