# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby30 ruby31 ruby32"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="ChangeLog.markdown README.markdown"
RUBY_FAKEGEM_EXTENSIONS=(ext/do_sqlite3/extconf.rb)

inherit multilib ruby-fakegem

DESCRIPTION="Implements the DataObjects API for Sqlite3"
HOMEPAGE="http://rubygems.org/gems/do_sqlite3"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Specs depend on spec files from data_objects, which we no longer
# install by default.
RESTRICT="test"

RDEPEND="${RDEPEND} dev-db/sqlite:3"
DEPEND="${DEPEND} dev-db/sqlite:3"

ruby_add_bdepend "test? ( dev-ruby/bacon )"

ruby_add_rdepend "~dev-ruby/data_objects-${PV}"

each_ruby_compile() {
	# We have injected --no-undefined in Ruby as a safety precaution
	# against broken ebuilds, but these bindings unfortunately rely on
	# the lazy load of other extensions; see bug #320545.
	find . -name Makefile -print0 | xargs -0 \
		sed -i -e 's:-Wl,--no-undefined::' || die "--no-undefined removal failed"
	each_fakegem_compile
}
