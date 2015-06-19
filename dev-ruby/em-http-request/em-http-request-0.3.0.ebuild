# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/metasploit_data_models/metasploit_data_models-0.17.0.ebuild,v 1.3 2014/07/09 21:13:54 zerochaos Exp $

EAPI=5
USE_RUBY="ruby19"

inherit ruby-fakegem versionator

DESCRIPTION="EventMachine based, async HTTP Request client"
HOMEPAGE="http://github.com/igrigorik/em-http-request"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "
	>=dev-ruby/addressable-2.0.0
	>=dev-ruby/eventmachine-0.12.9
	"

#FIXME:
#escape_utils >= 0
