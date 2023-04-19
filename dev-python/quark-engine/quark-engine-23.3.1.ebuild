# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="An Obfuscation-Neglect Android Malware Scoring System"
HOMEPAGE="https://github.com/quark-engine/quark-engine"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64"
IUSE=""

RDEPEND="dev-python/prettytable[${PYTHON_USEDEP}]
	dev-util/androguard[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/graphviz[${PYTHON_USEDEP}]
	dev-python/prompt-toolkit[${PYTHON_USEDEP}]
	dev-python/plotly[${PYTHON_USEDEP}]
	dev-python/rzpipe[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare(){
	#relax deps
	sed "s|==|>=|g" -i setup.py || die
	rm -r tests
	default
}
