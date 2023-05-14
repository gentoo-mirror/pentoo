# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby30 ruby31 ruby32"

RUBY_FAKEGEM_NAME="origami"
RUBY_FAKEGEM_TASK_TEST="test"

inherit ruby-fakegem

DESCRIPTION="A Ruby framework designed to parse, analyze, and forge PDF documents"
HOMEPAGE="https://github.com/gdelugre/origami"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

ruby_add_bdepend "test? ( dev-ruby/minitest:5 )"
ruby_add_rdepend "dev-ruby/colorize"

all_ruby_install() {
	all_fakegem_install

	#Gentoo bug, remove links to directories
	rm "${ED}/usr/bin"/shell
	rm "${ED}/usr/bin"/gui
	rm "${ED}/usr/bin"/config

}
