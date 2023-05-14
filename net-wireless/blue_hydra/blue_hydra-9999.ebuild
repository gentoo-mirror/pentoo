# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby30 ruby31 ruby32"

inherit ruby-ng systemd

DESCRIPTION="bluetooth discovery service built on top of bluez"
HOMEPAGE="https://github.com/zerochaos-/blue_hydra"
SRC_URI=""

LICENSE="BSD-4"
SLOT="0"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/zerochaos-/blue_hydra.git"
	EGIT_CHECKOUT_DIR="${WORKDIR}"/all
else
	KEYWORDS="~amd64 ~x86"
	#strictly speaking this isn't a blue_hydra version number but a random simulation of a Pwnie Express software release number
	#but close enough for pushing out stable releases
	SRC_URI="https://github.com/zerochaos-/blue_hydra/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

IUSE="development ubertooth"

DEPEND=""
PDEPEND="dev-python/dbus-python
		>=net-wireless/bluez-5.46[test-programs,deprecated(+)]
		ubertooth? ( net-wireless/ubertooth )"

test_deps="dev-ruby/rake dev-ruby/rspec:2"
ruby_add_bdepend "dev-ruby/bundler:2
		test? ( ${test_deps} )"
ruby_add_rdepend "dev-ruby/dm-migrations
		dev-ruby/dm-sqlite-adapter
		dev-ruby/dm-timestamps
		dev-ruby/dm-validations
		dev-ruby/louis
	development? ( dev-ruby/pry
			${test_deps} )"

all_ruby_unpack() {
	if [[ ${PV} == "9999" ]]; then
		git-r3_src_unpack
	else
		default_src_unpack
	fi
}

all_ruby_prepare() {
	[ -f Gemfile.lock ] && rm Gemfile.lock
	if ! use development; then
		sed -i -e "/^group :development do/,/^end$/d" Gemfile || die
	fi
	if ! use test; then
		sed -i -e "/^group :test do/,/^end$/d" Gemfile || die
	fi
	if ! use test && ! use development; then
		sed -i -e "/^group :test, :development do/,/^end$/d" Gemfile || die
	fi
	sed -i -e '/simplecov/I s:^:#:' spec/spec_helper.rb || die
}

each_ruby_prepare() {
	if [ -f Gemfile ]
	then
		GEM_HOME="${T}" BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
		GEM_HOME="${T}" BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
	fi
}

each_ruby_test() {
	ruby-ng_rspec || die
	rm blue_hydra.log || die
	rm blue_hydra.yml || die
	rm blue_hydra_rssi.log || die
	rm blue_hydra_chunk.log || die
}

all_ruby_install() {
	dodir /usr/share/doc/${PF}
	cp -R {README.md,TODO} "${ED}"/usr/share/doc/${PF} || die
	rm {README.md,TODO,LICENSE} || die

	rm -r spec || die
	if [ -f Gemfile ]; then
		rm Gemfile || die
	fi
	if [ -f Gemfile.lock ]; then
		rm Gemfile.lock || die
	fi

	newinitd packaging/openrc/blue_hydra.initd blue_hydra
	newconfd packaging/openrc/blue_hydra.confd blue_hydra
	systemd_dounit packaging/systemd/blue_hydra.service

	dodir /usr/$(get_libdir)/${PN}
	#remove some things we don't want installed in libdir
	rm -r packaging/* || die
	rm Rakefile || die
	cp -R * "${ED}"/usr/$(get_libdir)/${PN}
	fowners -R root:0 /

	dodir /usr/sbin
	cat <<-EOF > "${ED}"/usr/sbin/blue_hydra
		#! /bin/sh
		cd /usr/$(get_libdir)/${PN}
		exec /usr/bin/env ruby -S ./bin/blue_hydra \$@
	EOF
	fperms +x /usr/sbin/blue_hydra

	#these directories need to exist for blue_hydra to know it's installed system-wide
	keepdir /var/log/blue_hydra
	keepdir /etc/blue_hydra
}
