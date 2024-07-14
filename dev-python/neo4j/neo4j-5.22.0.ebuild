# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_SETUPTOOLS=rdepend
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Neo4j Bolt driver for Python"
HOMEPAGE="https://github.com/neo4j/neo4j-python-driver"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"

RESTRICT="!test? ( test )"

RDEPEND="dev-python/pytz[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
