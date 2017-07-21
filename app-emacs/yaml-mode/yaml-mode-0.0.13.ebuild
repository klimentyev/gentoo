# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit elisp

DESCRIPTION="A major mode for GNU Emacs for editing YAML files"
HOMEPAGE="https://github.com/yoshiki/yaml-mode"
SRC_URI="https://github.com/yoshiki/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

#S="${WORKDIR}/${PN}-release-${PV}"
DOCS="README Changes"
SITEFILE="50${PN}-gentoo.el"
