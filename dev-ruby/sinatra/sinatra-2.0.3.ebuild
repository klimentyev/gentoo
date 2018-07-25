# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
USE_RUBY="ruby23 ruby24 ruby25"

RUBY_FAKEGEM_TASK_TEST="test:core"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_EXTRADOC="README.md AUTHORS.md CHANGELOG.md"

RUBY_FAKEGEM_GEMSPEC="sinatra.gemspec"

inherit ruby-fakegem

DESCRIPTION="A DSL for quickly creating web applications in Ruby with minimal effort"
HOMEPAGE="http://www.sinatrarb.com/"
SRC_URI="https://github.com/sinatra/sinatra/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "
	dev-ruby/mustermann:1
	dev-ruby/rack:2.0
	=dev-ruby/rack-protection-2.0.3
	dev-ruby/tilt:2"
ruby_add_bdepend "test? ( >=dev-ruby/rack-test-0.5.6 dev-ruby/erubis dev-ruby/builder )"
ruby_add_bdepend "doc? ( dev-ruby/yard )"
