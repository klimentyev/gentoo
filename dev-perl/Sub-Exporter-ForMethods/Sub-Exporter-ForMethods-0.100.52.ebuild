# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR=RJBS
DIST_VERSION=0.100052
inherit perl-module

DESCRIPTION="Helper routines for using Sub::Exporter to build methods"

SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE="test"

RDEPEND="
	virtual/perl-Scalar-List-Utils
	>=dev-perl/Sub-Exporter-0.978.0
	dev-perl/Sub-Name
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		virtual/perl-Carp
		virtual/perl-File-Spec
		>=virtual/perl-Test-Simple-0.960.0
		dev-perl/namespace-autoclean
	)
"
