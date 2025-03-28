# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby31 ruby32"
RUBY_FAKEGEM_BINDIR="exe"

inherit ruby-fakegem

DESCRIPTION="Interactive Ruby command-line tool for REPL"
HOMEPAGE="https://github.com/ruby/irb"

KEYWORDS="amd64 ~arm64 x86"
LICENSE="BSD"
SLOT="0"

ruby_add_rdepend "
	dev-ruby/reline
"
