# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

MY_PN="jd-gui"
MY_P="jd-gui-${PV}"

inherit eutils multilib rpm

DESCRIPTION="A standalone graphical utility that displays Java source codes of .class file"
HOMEPAGE="http://jd.benow.ca/"
SRC_URI="https://github.com/java-decompiler/jd-gui/releases/download/v${PV}/${MY_P}-0.noarch.rpm"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="virtual/jre"

S="${WORKDIR}/opt/jd-gui"

src_install() {
	dodir /opt/"${MY_PN}"
	insinto /opt/"${MY_PN}"
	doins "${MY_P}.jar"

	doicon jd_icon_128.png
	domenu jd-gui.desktop

	echo -e "#!/bin/sh\njava -jar /opt/${MY_PN}/${MY_P}.jar >/dev/null 2>&1 &\n" > "${MY_PN}"
	dobin "${MY_PN}"
}
