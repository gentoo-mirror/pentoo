# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby31 ruby32"

inherit ruby-fakegem

DESCRIPTION="Rack CORS Middleware"
HOMEPAGE="https://github.com/cyu/rack-cors"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

ruby_add_rdepend "
	>=dev-ruby/rack-2.0.0
"
