# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="Capture, repeat and live intercept HTTP requests"
HOMEPAGE="https://github.com/MobSF/httptools"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
#IUSE="test"

RDEPEND="net-proxy/mitmproxy[${PYTHON_USEDEP}]
	>=dev-python/markupsafe-2.1.3[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare(){
	sed -i "s|'mitmproxy.*'|'mitmproxy'|g" setup.py
	eapply_user
}
