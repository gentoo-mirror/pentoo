# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Python API for IP2Location database"
HOMEPAGE="https://pypi.org/project/IP2Location/"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
HASH_COMMIT="71828f8506cab07f8379faa815fc257ad9d8ca7a"
SRC_URI="https://github.com/chrislim2888/IP2Location-Python/archive/refs/tags/${PV}.tar.gz  -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
RESTRICT="test"

S="${WORKDIR}/IP2Location-Python-${PV}"
