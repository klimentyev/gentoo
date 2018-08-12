# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Virtual for Java Runtime Environment (JRE)"
SLOT="${PV}"
KEYWORDS="~amd64 ~x64-macos ~sparc64-solaris"

RDEPEND="|| (
	virtual/jdk:${SLOT}
	dev-java/openjdk-bin:${SLOT}[gentoo-vm(+)]
)"
