# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils eutils

DESCRIPTION="Library and tool for personalization of Yubico's YubiKey NEO"
HOMEPAGE="http://opensource.yubico.com/yubioath-desktop"
SRC_URI="https://github.com/Yubico/yubioath-desktop/releases/download/${P}/${P}.tar.gz -> ${P}.tar"

KEYWORDS="~amd64"
SLOT="4"
LICENSE="BSD-2"

RDEPEND="dev-qt/qtsingleapplication
	dev-python/pyotherside"
DEPEND="${RDEPEND}
	>=app-crypt/yubikey-manager-0.5
	dev-qt/qtdeclarative"

#upstream is not consistent with this
S=${WORKDIR}/${PN}

src_configure() {
	eqmake5 yubioath-desktop.pro
	python build_qrc.py resources.json
}

src_install() {
	emake install INSTALL_ROOT="${D}"
	domenu resources/yubioath-desktop.desktop
	doicon resources/icons/yubioath.png

	emake compiler_rcc_make_all
	emake compiler_buildqrc_make_all
	emake compiler_moc_header_make_all
}
