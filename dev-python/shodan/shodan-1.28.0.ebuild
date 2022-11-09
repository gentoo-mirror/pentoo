# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Python library and command-line utility for Shodan"
HOMEPAGE="https://github.com/achillean/shodan-python/tree/master https://pypi.org/project/shodan/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

#No such file or directory: 'SHODAN-API-KEY'
RESTRICT="test"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/click-plugins[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	>=dev-python/requests-2.2.1[${PYTHON_USEDEP}]
	dev-python/xlsxwriter[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
#	test? (
#		dev-python/nose[${PYTHON_USEDEP}]
#		dev-python/pytest[${PYTHON_USEDEP}]
#	)"

#python_test() {
#	nosetests --verbose || die
#	py.test -v -v || die
#}
