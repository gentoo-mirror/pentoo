# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#https://projects.gentoo.org/python/guide/distutils.html#pep-517-build-systems
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="OpenStep plist reader into python objects"
HOMEPAGE="https://github.com/kronenthaler/openstep-parser"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test"

RDEPEND="dev-python/nose[${PYTHON_USEDEP}]
	dev-python/coverage[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest
