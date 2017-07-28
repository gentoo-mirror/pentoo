# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby22 ruby23 ruby24"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="Changelog README.md"
RUBY_FAKEGEM_RECIPE_TEST=""

inherit ruby-fakegem

DESCRIPTION="Provides simple parsing of standard *nix style config files."
HOMEPAGE="https://github.com/datafolklabs/ruby-parseconfig"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
