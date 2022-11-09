# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )
inherit cmake git-r3 python-single-r1

DESCRIPTION="GNU Radio block for Digital Speech Decoder"
HOMEPAGE="https://github.com/argilo/gr-dsd"

EGIT_REPO_URI="https://github.com/argilo/gr-dsd.git"
EGIT_BRANCH="maint-3.8"

LICENSE="GPL-3"
SLOT="0"
IUSE="doc"
DEPEND=">=net-wireless/gnuradio-3.7.0:=
	dev-libs/boost:=
	media-libs/libsndfile
	dev-util/cppunit
	sci-libs/itpp
	>=dev-libs/log4cpp-1.1:=
	dev-lang/swig:*
	doc? ( app-doc/doxygen )
	${PYTHON_DEPS}"

RDEPEND="${DEPEND}"

src_configure() {
	sed -i '0,/include\/dsd/s/include\/dsd/include\/gnuradio\/dsd/' ${WORKDIR}/${P}/CMakeLists.txt || die 'sed failed'
	local mycmakeargs=(
		-DWITH_ENABLE_DOXYGEN=YES="$(usex doc)"
		-DPYTHON_EXECUTABLE="${PYTHON}"
	)
	cmake_src_configure
}
