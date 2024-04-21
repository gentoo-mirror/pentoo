# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="jadx"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A standalone graphical Java Decompiler"
HOMEPAGE="https://github.com/skylot/jadx"
SRC_URI="https://github.com/skylot/jadx/releases/download/v${PV}/${MY_P}.zip"

S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="virtual/jre"
BDEPEND="app-arch/unzip"

src_prepare() {
	sed -e 's|APP_HOME="`pwd -P`"|APP_HOME="/opt/jadx-bin/"|' -i bin/${MY_PN} || die "sed failed"
	sed -e 's|APP_HOME="`pwd -P`"|APP_HOME="/opt/jadx-bin/"|' -i bin/${MY_PN}-gui || die "sed failed"
	eapply_user
}

src_install() {
	insinto /opt/"${PN}"
	dodir /opt/"${PN}"
	doins -r *
	fperms -R 755 "${INSTALL_DIR}/opt/${PN}/bin/${MY_PN}"
	fperms -R 755 "${INSTALL_DIR}/opt/${PN}/bin/${MY_PN}-gui"
	dosym -r "${EPREFIX}"/opt/${PN}/bin/${MY_PN} /usr/bin/${MY_PN}
	dosym -r "${EPREFIX}"/opt/${PN}/bin/${MY_PN}-gui /usr/bin/${MY_PN}-gui

#	doicon jd_icon_128.png
#	domenu jd-gui.desktop

#	echo -e "#!/bin/sh\njava -jar /opt/${MY_PN}/${MY_P}.jar >/dev/null 2>&1 &\n" > "${MY_PN}"

}
