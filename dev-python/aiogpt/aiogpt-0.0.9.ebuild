# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
#SRC_URI=https://github.com/acheong08/ChatGPT/archive/refs/tags/0.0.44.tar.gz

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
#IUSE="test"

RDEPEND="dev-python/aiohttp[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest
