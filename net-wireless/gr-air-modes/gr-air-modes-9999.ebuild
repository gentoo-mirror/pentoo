# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit python cmake-utils git-2

DESCRIPTION="This module implements a complete Mode S and ADS-B receiver for Gnuradio"
HOMEPAGE="https://www.cgran.org/wiki/gr-air-modes"

EGIT_REPO_URI="https://github.com/bistromath/gr-air-modes.git"
#still on gr 3.6
#EGIT_BRANCH="master"
#we use for 3.7... for now
EGIT_BRANCH="next"

KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE="rtl fgfs +gui uhd"
DEPEND=">=net-wireless/gnuradio-3.7.0:=
	net-wireless/gr-osmosdr
	dev-python/pyzmq
	dev-libs/boost:=
	fgfs? ( sci-libs/scipy
		games-simulation/flightgear )
	rtl? ( net-wireless/rtl-sdr )
	uhd? ( >=net-wireless/uhd-3.4.0 )
	gui? ( dev-python/pyqwt )"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_compile() {
	cmake-utils_src_compile -j1
}

src_install() {
	cmake-utils_src_install
	python_convert_shebangs 2 "${ED}"usr/bin/*
	use rtl && newbin "${FILESDIR}"/modes.py rtl_modes.py
	use uhd && newbin "${FILESDIR}"/modes.py uhd_modes.py
}
