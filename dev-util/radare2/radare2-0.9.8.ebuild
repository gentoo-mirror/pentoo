# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv Exp $

EAPI=5
inherit base eutils versionator

#MY_PV="$(replace_version_separator 3 '-')"

DESCRIPTION="Advanced command line hexadecimal editor and more"
HOMEPAGE="http://www.radare.org"
SRC_URI="https://github.com/radare/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+capstone debug ewf ssl"

RDEPEND="capstone? ( >dev-util/capstone-2.1.2:= )
	!dev-util/radare2-capstone
	ssl? ( dev-libs/openssl:= )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare(){
	epatch "${FILESDIR}"/radare2-0.9.8-makefile.patch
}

src_configure() {
	econf $(use ssl || echo --without-openssl ) \
		$(use ewf || echo --without-ewf ) \
		$(use debug || echo --disable-debugger ) \
		--with-syscapstone
}

src_install() {
	emake DESTDIR="${D}" INSTALL_PROGRAM="install" install
}

pkg_postinst(){
	ewarn "You might want to set a default backend in the following file:"
	ewarn "~/.config/radare2/radarerc"
}
