# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="Insomnia.Core"

DESCRIPTION="REST API client, a postman alternative"
HOMEPAGE="https://github.com/Kong/insomnia https://insomnia.rest/"
SRC_URI="https://github.com/Kong/insomnia/releases/download/core%40${PV}/${MY_PN}-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

QA_PREBUILT="opt/Insomnia.Core/insomnia /opt/Insomnia.Core/chrome-sandbox
	opt/Insomnia.Core/chrome_crashpad_handler
	opt/Insomnia.Core/*.so.1
	opt/Insomnia.Core/*.so"

src_install() {
	dodir /opt/${MY_PN}
	cp -R "${S}"/* "${D}"/opt/${MY_PN} || die "Copy files failed"
	dosym -r /opt/${MY_PN}/insomnia /usr/bin/insomnia
}
