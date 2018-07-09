# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR=BOOK
DIST_VERSION=0.403
inherit perl-module

DESCRIPTION="Convert between DateTime and RFC2822/822 formats"

SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 ~sparc x86 ~x86-fbsd ~x86-solaris"
IUSE="test"

RDEPEND="
	virtual/perl-Carp
	>=dev-perl/DateTime-1.40.0
	dev-perl/Params-Validate
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		virtual/perl-File-Spec
		virtual/perl-Test-Simple
	)
"

src_test() {
	perl_rm_files t/author-*.t t/release-*.t
	perl-module_src_test
}
