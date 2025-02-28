# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1

DESCRIPTION="Common interface for scrapy data container classes"
HOMEPAGE="https://scrapy.org/"
SRC_URI="https://github.com/scrapy/itemadapter/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT=0
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"
BDEPEND="${DEPEND}
	test? (
		dev-python/attrs[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-python/Scrapy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
