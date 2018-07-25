# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Virtual for Message Transfer Agents"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

# mail-mta/citadel is from sunrise
RDEPEND="|| (	>=mail-mta/ssmtp-2.64-r2[mta]
				<mail-mta/ssmtp-2.64-r2
				mail-mta/courier
				mail-mta/esmtp
				mail-mta/exim
				mail-mta/mini-qmail
				>=mail-mta/msmtp-1.4.19-r1[mta]
				<mail-mta/msmtp-1.4.19-r1
				mail-mta/netqmail
				mail-mta/nullmailer
				mail-mta/postfix
				mail-mta/qmail-ldap
				mail-mta/sendmail
				mail-mta/opensmtpd
				mail-mta/citadel[-postfix] )"
