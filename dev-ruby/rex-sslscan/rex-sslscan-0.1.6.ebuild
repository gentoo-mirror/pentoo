# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby30 ruby31 ruby32"
#RUBY_FAKEGEM_RECIPE_TEST="rspec3"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="ruby implmenetation of the SSLScan tool "
HOMEPAGE="https://rubygems.org/gems/rex-sslscan"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE=""

# doesn't seem to actually run any tests
RESTRICT=test

PDEPEND="dev-libs/openssl"
ruby_add_rdepend "dev-ruby/rex-core
	dev-ruby/rex-socket
	dev-ruby/rex-text"
