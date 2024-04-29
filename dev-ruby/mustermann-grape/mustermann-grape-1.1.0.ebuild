# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby31 ruby32"

inherit ruby-fakegem

DESCRIPTION="Adds Grape style patterns to Mustermman"
HOMEPAGE="https://github.com/ruby-grape/mustermann-grape"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

ruby_add_rdepend "
	>=dev-ruby/mustermann-1.0.0
"
