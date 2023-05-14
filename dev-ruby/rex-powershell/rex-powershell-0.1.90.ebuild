# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby30 ruby31 ruby32"

RUBY_FAKEGEM_EXTRAINSTALL="data"
RUBY_FAKEGEM_RECIPE_TEST="none"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_BINWRAP=""

#FIXME convert to:
#RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"
#after the issue is fixed https://github.com/rapid7/rex-powershell/issues/26

inherit ruby-fakegem

DESCRIPTION="Ruby Exploitation(Rex) library for generating/manipulating Powershell scripts"
HOMEPAGE="https://rubygems.org/gems/rex-powershell"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE=""

ruby_add_bdepend "dev-ruby/rex-random_identifier
		dev-ruby/rex-text
		dev-ruby/ruby-rc4"
