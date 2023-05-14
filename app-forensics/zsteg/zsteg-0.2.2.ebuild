# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby30 ruby31 ruby32"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="Detect stegano-hidden data in PNG & BMP"
HOMEPAGE="https://github.com/zed-0xff/zsteg"
SRC_URI="https://github.com/zed-0xff/zsteg/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

ruby_add_rdepend "
	dev-ruby/iostruct
	dev-ruby/zpng"

ruby_add_bdepend "dev-ruby/bundler"
