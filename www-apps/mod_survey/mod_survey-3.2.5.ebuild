# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=0

inherit depend.apache webapp

WEBAPP_MANUAL_SLOT="yes"
SLOT="0"

MY_PN=${PN/_/}

DESCRIPTION="XML-defined web questionnaires as a plug-in module using Apache"
HOMEPAGE="http://www.modsurvey.org"
SRC_URI="http://www.modsurvey.org/download/tarballs/${MY_PN}-${PV}.tgz
	doc? ( http://www.modsurvey.org/download/tarballs/${MY_PN}-docs-${PV}.tgz )"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc mysql nls postgres"

DEPEND=">=dev-lang/perl-5.6.1"
RDEPEND="${DEPEND}
	>=www-apache/mod_perl-1.99
	postgres? ( >=dev-perl/DBI-1.38 dev-perl/DBD-Pg )
	mysql? ( >=dev-perl/DBI-1.38 dev-perl/DBD-mysql )
	>=dev-perl/CGI-3.0.0"

S="${WORKDIR}"/${MY_PN}-${PV}

pkg_setup() {
	webapp_pkg_setup
	has_apache

	if use nls; then
		ewarn "English will be set as the default language."
		ewarn "This can be overriden on a per-survey basis, or changed in"
		ewarn "${APACHE_MODULES_CONFDIR}/98_${PN}.conf"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s|/usr/local/mod_survey/|${D}/usr/lib/mod_survey/|g" \
		installer.pl

	rm -f docs/LICENSE.txt
	use doc && unpack ${MY_PN}-docs-${PV}.tgz
}

src_install() {
	webapp_src_preinst

	dodir /usr/lib/mod_survey
	dodir /var/lib/mod_survey

	dodoc README.txt docs/*
	rm -rf README.txt docs/

	insinto /usr/share/doc/${PF}
	doins -r webroot/examples*
	rm -rf webroot/examples*

	perl installer.pl < /dev/null > /dev/null 2>&1
	rm -rf "${D}"/usr/lib/mod_survey/{survey.conf,data,docs,webroot}

	insinto "${MY_HTDOCSDIR}"
	doins -r webroot/{main.css,system}

	insinto "${APACHE_MODULES_CONFDIR}"
	doins "${FILESDIR}"/98_${PN}.conf

	fowners apache:apache /var/lib/mod_survey

	webapp_src_install
}
