# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Library for cross-platform C locale functions"
HOMEPAGE="https://github.com/libyal/${PN}"
SRC_URI="https://github.com/libyal/${PN}/releases/download/${PV}/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="debug nls unicode"

DEPEND="dev-libs/libcerror
	dev-libs/libclocale
	dev-libs/libcnotify
	dev-libs/libuna
	dev-libs/libcstring
"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable unicode wide-character-type) \
		$(use_enable debug debug-output) \
		$(use_enable debug verbose-output) \
		--with-libcerror \
		--with-libclocale \
		--with-libuna \
		--with-libcstring
}
