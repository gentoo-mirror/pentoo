# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/metasploit_data_models/metasploit_data_models-0.17.0.ebuild,v 1.3 2014/07/09 21:13:54 zerochaos Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_EXTRAINSTALL="app spec"

inherit ruby-fakegem versionator

DESCRIPTION="Metasploit concern allows you to define concerns in app/concerns. "
HOMEPAGE="https://github.com/rapid7/metasploit-concern"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="BSD"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~x86"
#IUSE="development test"
RESTRICT=test
IUSE=""

RDEPEND="${RDEPEND} !dev-ruby/metasploit-concern:0"

ruby_add_rdepend "<dev-ruby/railties-4.0.0
				dev-ruby/activesupport:3.2"

#all_ruby_prepare() {
#	[ -f Gemfile.lock ] && rm Gemfile.lock
	#For now, we don't support development or testing at all
	#if ! use development; then
#		sed -i -e "/^group :development do/,/^end$/d" Gemfile || die
#		sed -i -e "/s.add_development_dependency/d" "${PN}".gemspec || die
	#fi
	#if ! use test; then
#		sed -i -e "/^group :test do/,/^end$/d" Gemfile || die
	#fi
	#if ! use test && ! use development; then
#		sed -i -e "/^group :development, :test do/,/^end$/d" Gemfile || die
	#fi
#}

#each_ruby_prepare() {
#	if [ -f Gemfile ]
#	then
#		BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
#		BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
#	fi
#}

