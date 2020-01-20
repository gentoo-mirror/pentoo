# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby24 ruby25"

inherit ruby-ng

DESCRIPTION="Web-based application for effective reporting writing"
HOMEPAGE="https://www.itdefence.asia"
#SRC_URI="${P}.tar.gz"

LICENSE="none"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+mysql"

RDEPEND="mysql? ( virtual/mysql )"

ruby_add_rdepend "dev-ruby/rake
	dev-ruby/rails:4.2
	dev-ruby/rack:1.6
	dev-ruby/rubygems
	dev-ruby/will_paginate
	dev-ruby/jquery-rails:4
	dev-ruby/ckeditor_rails
	dev-ruby/activerecord-session_store
	dev-ruby/protected_attributes
	dev-ruby/similar_text
	dev-ruby/sablon
	mysql? ( dev-ruby/mysql2:0.5 )"

#fix me: group :assets
ruby_add_bdepend "
	|| ( dev-ruby/coffee-rails:4.1 dev-ruby/coffee-rails:4.2 )
"

each_ruby_prepare() {
	if [ -f Gemfile ]; then
		MSF_ROOT="." BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
		MSF_ROOT="." BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
	fi
}
