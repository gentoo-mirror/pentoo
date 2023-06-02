# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="async parser for JET"
HOMEPAGE="https://github.com/skelsec/aesedb"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
SRC_URI="https://github.com/skelsec/aesedb/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

#FIXME: no license
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""
RESTRICT="test"

RDEPEND=">=dev-python/unicrypto-0.0.9[${PYTHON_USEDEP}]
	>=dev-python/aiowinreg-0.0.7[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest

src_prepare(){
	rm -r tests
	eapply_user
}
