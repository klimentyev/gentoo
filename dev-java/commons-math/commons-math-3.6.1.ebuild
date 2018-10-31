# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-pkg-simple

MY_PN="${PN}3"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Lightweight, self-contained mathematics and statistics components"
HOMEPAGE="https://commons.apache.org/math/"
SRC_URI="https://repo1.maven.org/maven2/org/apache/commons/${MY_PN}/${PV}/${MY_P}-sources.jar
-> ${MY_P}.jar"

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
