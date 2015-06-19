# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils qt4-r2

DESCRIPTION="Library for guymager"
HOMEPAGE="http://libguytools.sourceforge.net/"
#SRC_URI="mirror://sourceforge/libguytools/${P}.tar.gz"
SRC_URI="mirror://debian/pool/main/libg/libguytools2/${P//-/_}.orig.tar.gz ->  ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE="debug"

DEPEND="dev-qt/qtcore"
RDEPEND="${DEPEND}"

src_prepare() {
	echo "VERSION = ${PV}" > libguytools_version.pro.inc
	epatch "${FILESDIR}"/toolsysinfo.cpp.diff
	epatch "${FILESDIR}"/toolcfg_memmove.patch
}

src_configure() {
	eqmake4 tools.pro
	eqmake4 toolsstatic.pro
}

src_install() {
	insinto /usr/include/libguytools2
	doins include/*.h
	dolib.a lib/libguytools.a
}
