# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
USE_RUBY="ruby22 ruby23 ruby24"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="CHANGES.md README.md"

inherit ruby-fakegem

DESCRIPTION="An easy-to-use client library for making requests from Ruby"
HOMEPAGE="https://github.com/tarcieri/http"

LICENSE="MIT"
SLOT="0.6"
KEYWORDS="amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/http_parser_rb-0.6.0 =dev-ruby/http_parser_rb-0.6*"

all_ruby_prepare() {
	sed -i -e '/simplecov/,/end/ s:^:#:' \
		-e '1irequire "cgi"' spec/spec_helper.rb || die
}
