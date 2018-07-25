# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_PHP="php5-6 php7-0 php7-1 php7-2"

inherit php-ext-pecl-r3

DESCRIPTION="An extension to track progress of a file upload"
LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	php_targets_php5-6? ( dev-lang/php:5.6[apache2] )
	php_targets_php7-0? ( dev-lang/php:7.0[apache2] )
	php_targets_php7-1? ( dev-lang/php:7.1[apache2] )
	php_targets_php7-2? ( dev-lang/php:7.2[apache2] )
"
PATCHES=( "${FILESDIR}/1.0.3.1-php7.patch" )
